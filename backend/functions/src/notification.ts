import * as admin from "firebase-admin";
import {onDocumentWritten} from "firebase-functions/v2/firestore";
import {logger} from "firebase-functions/v2";

interface NotificationPayload {
  notificationId: string;
  title: string;
  description: string;
  type: string;
  reportId?: string;
  actorUserId?: string;
  // Stamped by this function after every successful push.
  // Used to enforce a 30-minute cooldown on viral reports.
  lastPushedAt?: admin.firestore.Timestamp;
}

interface NotificationPreferences {
  pushEnabled?: boolean;
  likesEnabled?: boolean;
  dislikesEnabled?: boolean;
  reportCreatedEnabled?: boolean;
}

interface UserDocument {
  fcmTokens?: Record<string, string>;
  // ISO-8601 strings or Firestore Timestamps keyed by token key
  fcmTokenLastActiveAt?: Record<string, admin.firestore.Timestamp | string>;
  notificationPreferences?: NotificationPreferences;
}

const INVALID_TOKEN_CODES = new Set([
  "messaging/invalid-registration-token",
  "messaging/registration-token-not-registered",
]);

const COOLDOWN_MS = 30 * 60 * 1000; // 30 minutes

export const onNotificationCreated = onDocumentWritten(
  // Triggers on create AND update of any notification doc.
  // We use onDocumentWritten so the cooldown stamp (lastPushedAt)
  // can be checked on subsequent upserts of the same document.
  "users/{userId}/notifications/{notificationId}",

  async (event) => {
    const {userId, notificationId} = event.params;

    // Only process creates (before doc did not exist)
    const isCreate = !event.data?.before?.exists;
    if (!isCreate) {
      logger.info(`Skipping update event for ${notificationId}`);
      return;
    }

    const notification =
      event.data?.after?.data() as NotificationPayload | undefined;

    if (!notification) {
      logger.warn(`No data for notification ${notificationId}`);
      return;
    }

    // Cooldown guard — skip if a push was already sent within 30 min.
    // This protects against push spam on viral reports.
    const lastPushed = notification.lastPushedAt;
    if (lastPushed) {
      const elapsed = Date.now() - lastPushed.toMillis();
      if (elapsed < COOLDOWN_MS) {
        logger.info(
          `Cooldown active for ${notificationId} — skipping push`,
        );
        return;
      }
    }

    logger.info(
      `Processing notification ${notificationId} for user ${userId}`,
      {type: notification.type},
    );

    // Fetch recipient's FCM tokens
    const userSnap = await admin
      .firestore()
      .collection("users")
      .doc(userId)
      .get();

    if (!userSnap.exists) {
      logger.warn(`User ${userId} not found`);
      return;
    }

    const userData = userSnap.data() as UserDocument;

    // Check master push switch and per-type preferences
    const prefs = userData?.notificationPreferences;
    if (prefs?.pushEnabled === false) {
      logger.info(`User ${userId} has push notifications disabled`);
      return;
    }
    const notifType = notification.type;
    if (notifType === "reportLiked" && prefs?.likesEnabled === false) {
      logger.info(`User ${userId} has like notifications disabled`);
      return;
    }
    if (notifType === "reportDisliked" && prefs?.dislikesEnabled === false) {
      logger.info(`User ${userId} has dislike notifications disabled`);
      return;
    }
    if (
      notifType === "reportCreated" &&
      prefs?.reportCreatedEnabled === false
    ) {
      logger.info(`User ${userId} has report-created notifications disabled`);
      return;
    }

    const tokenMap = userData?.fcmTokens ?? {};
    const lastActiveMap = userData?.fcmTokenLastActiveAt ?? {};
    const TOKEN_TTL_MS = 90 * 24 * 60 * 60 * 1000; // 90 days
    const now = Date.now();

    const tokens = Object.entries(tokenMap)
      .filter(([key, t]) => {
        if (typeof t !== "string" || t.length === 0) return false;
        // If there is a lastActiveAt stamp, honour the TTL
        const lastActive = lastActiveMap[key];
        if (!lastActive) return true; // no stamp yet — keep token
        const activeMs = typeof lastActive === "string" ?
          new Date(lastActive).getTime() :
          lastActive.toMillis();
        return now - activeMs < TOKEN_TTL_MS;
      })
      .map(([, t]) => t as string);

    if (tokens.length === 0) {
      logger.info(`User ${userId} has no FCM tokens — skipping push`);
      return;
    }

    // Build FCM message
    const message: admin.messaging.MulticastMessage = {
      tokens,
      notification: {
        title: notification.title,
        body: notification.description,
      },
      data: {
        // All values must be strings in FCM data payload
        notificationId,
        type: notification.type,
        reportId: notification.reportId ?? "",
        actorUserId: notification.actorUserId ?? "",
      },
      android: {
        priority: "high",
        notification: {
          channelId: "civic24_notifications",
          priority: "high",
        },
      },
      apns: {
        payload: {
          aps: {
            badge: 1,
            sound: "default",
          },
        },
        headers: {
          "apns-priority": "10",
        },
      },
    };

    // Send to all devices
    const response = await admin.messaging().sendEachForMulticast(message);

    logger.info(
      `Push sent to ${userId}: ` +
      `${response.successCount} ok, ${response.failureCount} failed`,
    );

    // Stamp lastPushedAt so the next upsert of this doc can check cooldown
    await event.data?.after?.ref.update({
      lastPushedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Clean up expired/invalid tokens
    const expiredTokenKeys = Object.entries(tokenMap)
      .filter((_, index) => {
        const result = response.responses[index];
        return (
          result?.error?.code != null &&
          INVALID_TOKEN_CODES.has(result.error.code)
        );
      })
      .map(([key]) => key);

    if (expiredTokenKeys.length > 0) {
      logger.info(
        `Removing ${expiredTokenKeys.length} expired tokens for ${userId}`,
      );

      const updates: Record<string, admin.firestore.FieldValue> = {};
      for (const key of expiredTokenKeys) {
        updates[`fcmTokens.${key}`] = admin.firestore.FieldValue.delete();
      }

      await admin
        .firestore()
        .collection("users")
        .doc(userId)
        .update(updates);
    }
  },
);
