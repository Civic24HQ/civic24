import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:styles/styles.dart';

class ExpandingDotsIndicator extends StatelessWidget {
  const ExpandingDotsIndicator({required this.count, required this.currentIndex, this.onDotClicked, super.key})
    : assert(currentIndex >= 0 && currentIndex < count, 'currentIndex must be in the range of 0 to count - 1');

  /// The total number of dots.
  final int count;

  /// The current active dot index.
  final int currentIndex;

  /// Callback when a dot is clicked.
  final ValueChanged<int>? onDotClicked;

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: currentIndex,
      duration: const Duration(milliseconds: 500),
      count: count,
      onDotClicked: onDotClicked,
      effect: ExpandingDotsEffect(
        activeDotColor: context.primary,
        dotColor: context.neutralLow,
        dotHeight: AppDimensions.size8,
        dotWidth: AppDimensions.size12,
      ),
    );
  }
}
