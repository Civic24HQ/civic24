import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

class AppPost extends StatelessWidget {
  const AppPost({required this.postData, required this.onTapComment, super.key});

  final PostData postData;
  final VoidCallback onTapComment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppEdgeInsets.horizontalPadding12,
      child: Column(
        children: [
          AppSpacing.medium,
          SizedBox(
            width: double.infinity,
            child: Center(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: AppDimensions.size12,
                leading: ClipOval(
                  child: SizedBox(
                    width: AppDimensions.size40,
                    height: AppDimensions.size40,

                    child: AppCachedImage(imageUrl: postData.userImageUrl),
                  ),
                ),
                title: Text(postData.fullName, style: context.headlineSmall?.copyWith(fontSize: AppDimensions.size16)),
                subtitle: Text(
                  postData.location,
                  style: context.bodyLarge?.copyWith(color: context.neutralHigh, fontSize: AppDimensions.size14),
                ),
                trailing: Text(
                  postData.createdAt.timeAgoInWords,
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
            postData.content,
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
              child: AppCachedImage(imageUrl: postData.media?.first),
            ),
          ),
          AppSpacing.normal,
          Container(
            width: double.infinity,
            color: context.surface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(SolarIconsOutline.like, size: AppDimensions.size20, color: context.onSurfaceVariant),
                    AppSpacing.small,
                    Text(postData.likeCount.toString(), style: context.bodyMedium),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(SolarIconsOutline.dislike, size: AppDimensions.size20, color: context.onSurfaceVariant),
                    AppSpacing.small,
                    Text(postData.dislikeCount.toString(), style: context.bodyMedium),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: onTapComment,
                      child: Icon(SolarIconsOutline.chatRound, size: AppDimensions.size20, color: context.onSurfaceVariant),
                    ),
                    AppSpacing.small,
                    Text(postData.commentCount.toString(), style: context.bodyMedium),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(SolarIconsOutline.bookmark, size: AppDimensions.size20, color: context.onSurfaceVariant),
                    AppSpacing.small,
                    Text(postData.bookmarkCount.toString(), style: context.bodyMedium),
                  ],
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
