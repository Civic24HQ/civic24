import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styles/styles.dart';

/// A lightweight shimmer skeleton that mirrors the layout of `AppReport`.
class AppReportShimmer extends StatelessWidget {
  const AppReportShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = context.neutralHighest.withValues(alpha: 0.5);
    final highlightColor = context.neutralHighest.withValues(alpha: 0.2);

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
                leading: Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    width: AppDimensions.size40,
                    height: AppDimensions.size40,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(AppDimensions.size12),
                    ),
                  ),
                ),
                title: Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    height: 12,
                    width: 120,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(AppDimensions.size4),
                    ),
                  ),
                ),
                subtitle: Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    height: 10,
                    width: 80,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(AppDimensions.size4),
                    ),
                  ),
                ),
                trailing: Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    height: 10,
                    width: 40,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(AppDimensions.size4),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AppSpacing.small,
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              height: 14,
              width: double.infinity,
              decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(AppDimensions.size4)),
            ),
          ),
          AppSpacing.normal,
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              height: AppDimensions.size200,
              width: double.infinity,
              decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(AppDimensions.size4)),
            ),
          ),
          AppSpacing.normal,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
              (index) => Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                child: Container(
                  width: AppDimensions.size48,
                  height: AppDimensions.size24,
                  decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(AppDimensions.size4)),
                ),
              ),
            ),
          ),
          AppSpacing.standard,
        ],
      ),
    );
  }
}
