// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsJpgGen {
  const $AssetsJpgGen();

  /// File path: assets/jpg/profile.jpg
  AssetGenImage get profile => const AssetGenImage('assets/jpg/profile.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [profile];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/Success.json
  String get success => 'assets/lottie/Success.json';

  /// List of all assets
  List<String> get values => [success];
}

class $AssetsPngGen {
  const $AssetsPngGen();

  /// File path: assets/png/adaptive-icon.png
  AssetGenImage get adaptiveIcon =>
      const AssetGenImage('assets/png/adaptive-icon.png');

  /// File path: assets/png/civic24-app-logo.png
  AssetGenImage get civic24AppLogo =>
      const AssetGenImage('assets/png/civic24-app-logo.png');

  /// File path: assets/png/civic24-logo.png
  AssetGenImage get civic24Logo =>
      const AssetGenImage('assets/png/civic24-logo.png');

  /// File path: assets/png/civic24-logo2.png
  AssetGenImage get civic24Logo2 =>
      const AssetGenImage('assets/png/civic24-logo2.png');

  /// File path: assets/png/civic24-splash-screen-IOS.png
  AssetGenImage get civic24SplashScreenIOS =>
      const AssetGenImage('assets/png/civic24-splash-screen-IOS.png');

  /// File path: assets/png/civic24-splash-screen.png
  AssetGenImage get civic24SplashScreen =>
      const AssetGenImage('assets/png/civic24-splash-screen.png');

  /// File path: assets/png/pothole.png
  AssetGenImage get pothole => const AssetGenImage('assets/png/pothole.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    adaptiveIcon,
    civic24AppLogo,
    civic24Logo,
    civic24Logo2,
    civic24SplashScreenIOS,
    civic24SplashScreen,
    pothole,
  ];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/bold-circle1.svg
  SvgGenImage get boldCircle1 =>
      const SvgGenImage('assets/svg/bold-circle1.svg');

  /// File path: assets/svg/bold-circle2.svg
  SvgGenImage get boldCircle2 =>
      const SvgGenImage('assets/svg/bold-circle2.svg');

  /// File path: assets/svg/civic24-app-logo.svg
  SvgGenImage get civic24AppLogo =>
      const SvgGenImage('assets/svg/civic24-app-logo.svg');

  /// File path: assets/svg/civic24-logo.svg
  SvgGenImage get civic24Logo =>
      const SvgGenImage('assets/svg/civic24-logo.svg');

  /// File path: assets/svg/left-side.svg
  SvgGenImage get leftSide => const SvgGenImage('assets/svg/left-side.svg');

  /// File path: assets/svg/light.svg
  SvgGenImage get light => const SvgGenImage('assets/svg/light.svg');

  /// File path: assets/svg/onboardingOne.svg
  SvgGenImage get onboardingOne =>
      const SvgGenImage('assets/svg/onboardingOne.svg');

  /// File path: assets/svg/onboardingThree.svg
  SvgGenImage get onboardingThree =>
      const SvgGenImage('assets/svg/onboardingThree.svg');

  /// File path: assets/svg/onboardingTwo.svg
  SvgGenImage get onboardingTwo =>
      const SvgGenImage('assets/svg/onboardingTwo.svg');

  /// File path: assets/svg/outline-circle.svg
  SvgGenImage get outlineCircle =>
      const SvgGenImage('assets/svg/outline-circle.svg');

  /// File path: assets/svg/right-side.svg
  SvgGenImage get rightSide => const SvgGenImage('assets/svg/right-side.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    boldCircle1,
    boldCircle2,
    civic24AppLogo,
    civic24Logo,
    leftSide,
    light,
    onboardingOne,
    onboardingThree,
    onboardingTwo,
    outlineCircle,
    rightSide,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsJpgGen jpg = $AssetsJpgGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
  static const $AssetsPngGen png = $AssetsPngGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
