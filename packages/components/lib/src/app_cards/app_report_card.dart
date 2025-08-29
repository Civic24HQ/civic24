import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

class AppReport extends StatelessWidget {
  const AppReport({required this.reportData, required this.onTapComment, super.key});

  final ReportData reportData;
  final VoidCallback onTapComment;

  @override
  Widget build(BuildContext context) {
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
                    child: AppCachedImage(imageUrl: reportData.userImageUrl),
                  ),
                ),
                title: Text(
                  reportData.fullName,
                  style: context.headlineSmall?.copyWith(fontSize: AppDimensions.size16),
                ),
                subtitle: Text(
                  reportData.location,
                  style: context.bodyLarge?.copyWith(color: context.neutralHigh, fontSize: AppDimensions.size14),
                ),
                trailing: Text(
                  reportData.createdAt.timeAgoInWords,
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
            reportData.content,
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
              child: AppCachedImage(imageUrl: reportData.media?.first),
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
                    Text(reportData.likeCount.toString(), style: context.bodyMedium),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(SolarIconsOutline.dislike, size: AppDimensions.size20, color: context.onSurfaceVariant),
                    AppSpacing.small,
                    Text(reportData.dislikeCount.toString(), style: context.bodyMedium),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: onTapComment,
                      child: Icon(
                        SolarIconsOutline.chatRound,
                        size: AppDimensions.size20,
                        color: context.onSurfaceVariant,
                      ),
                    ),
                    AppSpacing.small,
                    Text(reportData.commentCount.toString(), style: context.bodyMedium),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(SolarIconsOutline.bookmark, size: AppDimensions.size20, color: context.onSurfaceVariant),
                    AppSpacing.small,
                    Text(reportData.bookmarkCount.toString(), style: context.bodyMedium),
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
