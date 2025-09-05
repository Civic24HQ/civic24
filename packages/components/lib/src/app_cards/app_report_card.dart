import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

class AppReport extends StatelessWidget {
  const AppReport({
    required this.reportData,
    required this.onTapComment,
    required this.onTapLike,
    required this.onTapDislike,
    required this.onTapBookmark,
    super.key,
  });

  final ReportWithUserState reportData;
  final VoidCallback onTapComment;
  final VoidCallback? onTapLike;
  final VoidCallback? onTapDislike;
  final VoidCallback? onTapBookmark;

  @override
  Widget build(BuildContext context) {
    final rawLiked = reportData.hasLiked;
    final rawDisliked = reportData.hasDisliked;

    // Normalize to exclusives (UI guard)
    final exclusiveLiked = rawLiked && !rawDisliked;
    final exclusiveDisliked = rawDisliked && !rawLiked;

    // Only allow like if not currently disliked, and vice versa
    final canLike = !exclusiveDisliked;
    final canDislike = !exclusiveLiked;

    return Padding(
      padding: AppEdgeInsets.horizontalPadding12,
      child: Column(
        children: [
          AppSpacing.small,
          SizedBox(
            width: double.infinity,
            child: Center(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: AppDimensions.size12,
                leading: SizedBox(
                  width: AppDimensions.size40,
                  height: AppDimensions.size40,
                  child: ClipRRect(
                    borderRadius: AppBorderRadius.radius12,
                    child: AppCachedImage(imageUrl: reportData.report.userImageUrl),
                  ),
                ),
                title: Text(
                  reportData.report.fullName,
                  style: context.headlineSmall?.copyWith(fontSize: AppDimensions.size16),
                ),
                subtitle: Text(
                  reportData.report.location,
                  style: context.bodyLarge?.copyWith(color: context.neutralHigh, fontSize: AppDimensions.size14),
                ),
                trailing: Text(
                  reportData.report.createdAt.timeAgoInWords,
                  style: context.bodyLarge?.copyWith(color: context.neutralHigh, fontSize: AppDimensions.size14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          AppSpacing.small,
          Text(
            reportData.report.content,
            style: context.bodyMedium,
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            textAlign: TextAlign.start,
          ),
          AppSpacing.normal,
          SizedBox(
            width: double.infinity,
            height: AppDimensions.size320,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.size8),
              child: AppCachedImage(imageUrl: reportData.report.media?.first),
            ),
          ),
          AppSpacing.normal,
          Container(
            width: double.infinity,
            color: context.surface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Opacity(
                  opacity: canLike ? 1 : 0.5,
                  child: SocialActionButton.thumbsUp(
                    isActive: exclusiveLiked,
                    count: reportData.report.likeCount,
                    activeColor: context.success,
                    inactiveColor: context.onSurfaceVariant,
                    onTap: canLike ? onTapLike : null,
                  ),
                ),
                Opacity(
                  opacity: canDislike ? 1 : 0.5,
                  child: SocialActionButton.thumbsDown(
                    isActive: exclusiveDisliked,
                    count: reportData.report.dislikeCount,
                    activeColor: context.error,
                    inactiveColor: context.onSurfaceVariant,
                    onTap: canDislike ? onTapDislike : null,
                  ),
                ),
                SocialActionButton.comment(onTap: onTapComment, count: reportData.report.commentCount,
                ),
                SocialActionButton.bookmark(
                  isActive: reportData.hasBookmarked,
                  count: reportData.report.bookmarkCount,
                  activeColor: context.warning,
                  inactiveColor: context.onSurfaceVariant,
                  onTap: onTapBookmark,
                ),
              ],
            ),
          ),
          AppSpacing.standard,
        ],
      ),
    );
  }
}
