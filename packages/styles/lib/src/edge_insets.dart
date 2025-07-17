import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:styles/src/dimensions.dart';

class AppEdgeInsets {
  AppEdgeInsets._();
  // Padding to margin on all sides
  static const EdgeInsets padding2 = EdgeInsets.all(AppDimensions.padding2);
  static const EdgeInsets padding4 = EdgeInsets.all(AppDimensions.padding4);
  static const EdgeInsets padding8 = EdgeInsets.all(AppDimensions.padding8);
  static const EdgeInsets padding12 = EdgeInsets.all(AppDimensions.padding12);
  static const EdgeInsets padding16 = EdgeInsets.all(AppDimensions.padding16);
  static const EdgeInsets padding24 = EdgeInsets.all(AppDimensions.padding24);
  static const EdgeInsets padding32 = EdgeInsets.all(AppDimensions.padding32);

  // Padding to add margin on horizontal sides
  static const EdgeInsets horizontalPadding2 = EdgeInsets.symmetric(horizontal: AppDimensions.padding2);
  static const EdgeInsets horizontalPadding4 = EdgeInsets.symmetric(horizontal: AppDimensions.padding4);
  static const EdgeInsets horizontalPadding8 = EdgeInsets.symmetric(horizontal: AppDimensions.padding8);
  static const EdgeInsets horizontalPadding12 = EdgeInsets.symmetric(horizontal: AppDimensions.padding12);
  static const EdgeInsets horizontalPadding16 = EdgeInsets.symmetric(horizontal: AppDimensions.padding16);
  static const EdgeInsets horizontalPadding24 = EdgeInsets.symmetric(horizontal: AppDimensions.padding24);
  static const EdgeInsets horizontalPadding32 = EdgeInsets.symmetric(horizontal: AppDimensions.padding32);

  // Padding to add margin on vertical sides
  static const EdgeInsets verticalPadding2 = EdgeInsets.symmetric(vertical: AppDimensions.padding2);
  static const EdgeInsets verticalPadding4 = EdgeInsets.symmetric(vertical: AppDimensions.padding4);
  static const EdgeInsets verticalPadding8 = EdgeInsets.symmetric(vertical: AppDimensions.padding8);
  static const EdgeInsets verticalPadding12 = EdgeInsets.symmetric(vertical: AppDimensions.padding12);
  static const EdgeInsets verticalPadding16 = EdgeInsets.symmetric(vertical: AppDimensions.padding16);
  static const EdgeInsets verticalPadding24 = EdgeInsets.symmetric(vertical: AppDimensions.padding24);
  static const EdgeInsets verticalPadding32 = EdgeInsets.symmetric(vertical: AppDimensions.padding32);

  /// The amount of horizontal padding to apply to a scrollable widget
  /// without narrowing the scrollable area.
  static EdgeInsets adaptiveHorizontalPadding(
    BuildContext context, {
    double padding = AppDimensions.padding16,
    double topPadding = 0,
  }) {
    final contentWidth = getAdaptivePageConstraint(context);
    final deviceWidth = MediaQuery.of(context).size.width;
    final double paddingSize = max((deviceWidth - contentWidth) / 2, padding);
    return EdgeInsets.only(left: paddingSize, right: paddingSize, top: topPadding);
  }
}
