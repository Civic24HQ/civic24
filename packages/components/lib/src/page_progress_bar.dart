import 'package:flutter/material.dart';
import 'package:styles/styles.dart';

/// A progress indicator that displays the progress of a multi-step process.
class PageProgressBar extends StatelessWidget {
  const PageProgressBar({
    this.currentPage = 1, // Default to the first page
    this.totalPages = 3, // Default to 3 pages
    super.key,
  }) : assert(currentPage >= 0, 'currentPage must be greater than or equal to 0'),
       assert(totalPages > 0, 'totalPages must be greater than 0'),
       assert(currentPage <= totalPages, 'currentPage must be less than or equal to totalPages');

  /// The current page to display in the progress indicator
  final int currentPage;

  /// The total number of pages to display in the progress indicator
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalPages, (stepIndex) {
        // Calculate progress for each segment using a simple clamp operation
        // where 0 (no progress) and 1 (full progress).
        final segmentProgress = (currentPage - stepIndex).clamp(0, 1);
        final isCurrentSegment = segmentProgress > 0;

        return Expanded(
          child: Padding(
            padding: AppEdgeInsets.horizontalPadding4,
            child: LinearProgressIndicator(
              value: segmentProgress.toDouble(),
              minHeight: AppDimensions.size8,
              borderRadius: AppBorderRadius.radius24,
              backgroundColor: context.neutralLow,
              valueColor: AlwaysStoppedAnimation<Color?>(isCurrentSegment ? context.primary : context.neutralLow),
            ),
          ),
        );
      }),
    );
  }
}
