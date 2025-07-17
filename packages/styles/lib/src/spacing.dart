import 'package:gap/gap.dart';
import 'package:styles/src/dimensions.dart';

class AppSpacing {
  AppSpacing._();

  // Add empty pixels
  static const tiny = Gap(AppDimensions.size2);
  static const small = Gap(AppDimensions.size4);
  static const medium = Gap(AppDimensions.size8);
  static const standard = Gap(AppDimensions.size12);
  static const normal = Gap(AppDimensions.size16);
  static const large = Gap(AppDimensions.size24);
  static const xLarge = Gap(AppDimensions.size32);
  static const xxLarge = Gap(AppDimensions.size48);
  static const xxxLarge = Gap(AppDimensions.size64);

  // Add empty pixels on slivers
  static const tinySliver = SliverGap(AppDimensions.size2);
  static const smallSliver = SliverGap(AppDimensions.size4);
  static const mediumSliver = SliverGap(AppDimensions.size8);
  static const standardSliver = SliverGap(AppDimensions.size12);
  static const normalSliver = SliverGap(AppDimensions.size16);
  static const largeSliver = SliverGap(AppDimensions.size24);
  static const xLargeSliver = SliverGap(AppDimensions.size32);
  static const xxLargeSliver = SliverGap(AppDimensions.size48);
  static const xxxLargeSliver = SliverGap(AppDimensions.size64);
}
