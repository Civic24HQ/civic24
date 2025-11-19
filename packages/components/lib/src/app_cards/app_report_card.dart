import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

class AppReport extends StatelessWidget {
  const AppReport({
    required this.report,
    required this.onTapComment,
    required this.onTapLike,
    required this.onTapDislike,
    required this.onTapBookmark,
    super.key,
  });

  final Report report;
  final VoidCallback onTapComment;
  final VoidCallback? onTapLike;
  final VoidCallback? onTapDislike;
  final VoidCallback? onTapBookmark;

  @override
  Widget build(BuildContext context) {
    final rawLiked = report.hasLiked;
    final rawDisliked = report.hasDisliked;

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
                    child: AppCachedImage(imageUrl: report.reportData.userImageUrl),
                  ),
                ),
                title: Text(
                  report.reportData.fullName,
                  style: context.headlineSmall?.copyWith(fontSize: AppDimensions.size16),
                ),
                subtitle: Text(
                  report.reportData.location,
                  style: context.bodyLarge?.copyWith(color: context.neutralHigh, fontSize: AppDimensions.size14),
                ),
                trailing: Text(
                  report.reportData.createdAt.timeAgoInWords,
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
            report.reportData.content,
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
              child: AppCachedImage(imageUrl: report.reportData.media?.first),
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
                    count: report.reportData.likeCount,
                    activeColor: context.success,
                    inactiveColor: context.onSurfaceVariant,
                    onTap: canLike ? onTapLike : null,
                  ),
                ),
                Opacity(
                  opacity: canDislike ? 1 : 0.5,
                  child: SocialActionButton.thumbsDown(
                    isActive: exclusiveDisliked,
                    count: report.reportData.dislikeCount,
                    activeColor: context.error,
                    inactiveColor: context.onSurfaceVariant,
                    onTap: canDislike ? onTapDislike : null,
                  ),
                ),
                SocialActionButton.comment(onTap: onTapComment, count: report.reportData.commentCount,
                ),
                SocialActionButton.bookmark(
                  isActive: report.hasBookmarked,
                  count: report.reportData.bookmarkCount,
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
