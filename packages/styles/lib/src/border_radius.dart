import 'package:flutter/material.dart';
import 'package:styles/src/dimensions.dart';

class AppBorderRadius {
  AppBorderRadius._();

  static BorderRadius get radius4 => BorderRadius.circular(AppDimensions.size4);
  static BorderRadius get radius8 => BorderRadius.circular(AppDimensions.size8);
  static BorderRadius get radius12 => BorderRadius.circular(AppDimensions.size12);
  static BorderRadius get radius16 => BorderRadius.circular(AppDimensions.padding16);
  static BorderRadius get radius20 => BorderRadius.circular(AppDimensions.size20);
  static BorderRadius get radius24 => BorderRadius.circular(AppDimensions.size24);
  static BorderRadius get radius28 => BorderRadius.circular(AppDimensions.size28);
  static BorderRadius get radius32 => BorderRadius.circular(AppDimensions.size32);
  static BorderRadius get radius36 => BorderRadius.circular(AppDimensions.size36);
  static BorderRadius get radius40 => BorderRadius.circular(AppDimensions.size40);

  static BorderRadius get topRadius12 => const BorderRadius.only(
    topLeft: Radius.circular(AppDimensions.size12),
    topRight: Radius.circular(AppDimensions.size12),
  );
  static BorderRadius get topRadius16 => const BorderRadius.only(
    topLeft: Radius.circular(AppDimensions.size16),
    topRight: Radius.circular(AppDimensions.size16),
  );
  static BorderRadius get topRadius24 => const BorderRadius.only(
    topLeft: Radius.circular(AppDimensions.size24),
    topRight: Radius.circular(AppDimensions.size24),
  );
  static BorderRadius get topRadius64 => const BorderRadius.only(
    topLeft: Radius.circular(AppDimensions.size64),
    topRight: Radius.circular(AppDimensions.size64),
  );
  static BorderRadius get bottomRadius12 => const BorderRadius.only(
    bottomLeft: Radius.circular(AppDimensions.size12),
    bottomRight: Radius.circular(AppDimensions.size12),
  );
  static BorderRadius get bottomRadius16 => const BorderRadius.only(
    bottomLeft: Radius.circular(AppDimensions.size16),
    bottomRight: Radius.circular(AppDimensions.size16),
  );
}
