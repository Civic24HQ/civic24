import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:platform/platform.dart';

const Platform _platform = LocalPlatform();

/// Set of desktop platforms for easy checks.
const _desktopPlatforms = {TargetPlatform.macOS, TargetPlatform.windows, TargetPlatform.linux};

/// True if the current device uses the Cupertino theme.
bool get isCupertino => {TargetPlatform.iOS, TargetPlatform.macOS}.contains(defaultTargetPlatform);

/// **Native Platform Checks (Excludes Web)**
bool get isIOS => !kIsWeb && _platform.isIOS;
bool get isAndroid => !kIsWeb && _platform.isAndroid;
bool get isMacOS => !kIsWeb && _platform.isMacOS;
bool get isWindows => !kIsWeb && _platform.isWindows;
bool get isLinux => !kIsWeb && _platform.isLinux;

/// **Web Browser Platform Checks**
bool get isWebOnIOS => kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;
bool get isWebOnAndroid => kIsWeb && defaultTargetPlatform == TargetPlatform.android;
bool get isWebOnMacOS => kIsWeb && defaultTargetPlatform == TargetPlatform.macOS;

/// **Grouped Checks**
bool get isNativeMobile => isIOS || isAndroid;
bool get isWebMobile => isWebOnIOS || isWebOnAndroid;
bool get isMobile => isNativeMobile || isWebMobile;
bool get isDesktop => _desktopPlatforms.contains(defaultTargetPlatform);
bool get isWebOrDesktop => kIsWeb || isDesktop;

/// Detect if running inside a Flutter test environment.
final bool isTest = !kIsWeb && io.Platform.environment['FLUTTER_TEST'] == 'true';

/// Check if the platform is both Web and considered Desktop.
bool isWebAndDesktop(BuildContext context) => kIsWeb && _desktopPlatforms.contains(Theme.of(context).platform);
