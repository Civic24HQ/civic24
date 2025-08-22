import 'package:flutter/material.dart';

abstract class AppDimensions {
  AppDimensions._();

  // Padding Sizes
  static const double padding2 = 2;
  static const double padding4 = 4;
  static const double padding8 = 8;
  static const double padding12 = 12;
  static const double padding16 = 16;
  static const double padding24 = 24;
  static const double padding32 = 32;

  // Sizes Dimensions
  static const double size2 = 2;
  static const double size4 = 4;
  static const double size6 = 6;
  static const double size8 = 8;
  static const double size12 = 12;
  static const double size14 = 14;
  static const double size16 = 16;
  static const double size20 = 20;
  static const double size24 = 24;
  static const double size28 = 28;
  static const double size32 = 32;
  static const double size36 = 36;
  static const double size40 = 40;
  static const double size48 = 48;
  static const double size56 = 56;
  static const double size64 = 64;
  static const double size72 = 72;
  static const double size80 = 80;
  static const double size96 = 96;
  static const double size120 = 120;
  static const double size150 = 150;
  static const double size180 = 180;
  static const double size192 = 192;
  static const double size200 = 200;
  static const double size240 = 240;
  static const double size300 = 300;
  static const double size320 = 320;
  static const double size350 = 350;
  static const double size375 = 375;
}

/// Derives a global constraint for pages based on client
///
/// Used to set the width on various pages in one place
double getAdaptivePageConstraint(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  return _isDisplayDesktop(context) ? 720 : mediaQuery.size.width;
}

bool _isDisplayDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 720;
