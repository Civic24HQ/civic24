import * as admin from "firebase-admin";

// Initialize Firebase Admin once
if (!admin.apps.length) {
  admin.initializeApp();
}

// Re-export all functions from individual modules
export {onNotificationCreated} from "./notification";
