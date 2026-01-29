// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i5;
import 'package:stacked/stacked.dart' as _i4;
import 'package:stacked_services/stacked_services.dart' as _i3;

import '../ui/views/home/home_view.dart' as _i1;
import '../ui/views/startup/startup_view.dart' as _i2;

final stackedRouter = StackedRouterWeb(
  navigatorKey: _i3.StackedService.navigatorKey,
);

class StackedRouterWeb extends _i4.RootStackRouter {
  StackedRouterWeb({_i5.GlobalKey<_i5.NavigatorState>? navigatorKey})
    : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomeViewRoute.name: (routeData) {
      final args = routeData.argsAs<HomeViewArgs>(
        orElse: () => const HomeViewArgs(),
      );
      return _i4.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i1.HomeView(key: args.key),
        opaque: true,
      );
    },
    StartupViewRoute.name: (routeData) {
      final args = routeData.argsAs<StartupViewArgs>(
        orElse: () => const StartupViewArgs(),
      );
      return _i4.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i2.StartupView(key: args.key),
        opaque: true,
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
    _i4.RouteConfig(HomeViewRoute.name, path: '/home-view'),
    _i4.RouteConfig(StartupViewRoute.name, path: '/'),
  ];
}

/// generated route for
/// [_i1.HomeView]
class HomeViewRoute extends _i4.PageRouteInfo<HomeViewArgs> {
  HomeViewRoute({_i5.Key? key})
    : super(
        HomeViewRoute.name,
        path: '/home-view',
        args: HomeViewArgs(key: key),
      );

  static const String name = 'HomeView';
}

class HomeViewArgs {
  const HomeViewArgs({this.key});

  final _i5.Key? key;

  @override
  String toString() {
    return 'HomeViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.StartupView]
class StartupViewRoute extends _i4.PageRouteInfo<StartupViewArgs> {
  StartupViewRoute({_i5.Key? key})
    : super(
        StartupViewRoute.name,
        path: '/',
        args: StartupViewArgs(key: key),
      );

  static const String name = 'StartupView';
}

class StartupViewArgs {
  const StartupViewArgs({this.key});

  final _i5.Key? key;

  @override
  String toString() {
    return 'StartupViewArgs{key: $key}';
  }
}

extension RouterStateExtension on _i3.RouterService {
  Future<dynamic> navigateToHomeView({
    _i5.Key? key,
    void Function(_i4.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(HomeViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> navigateToStartupView({
    _i5.Key? key,
    void Function(_i4.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(StartupViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> replaceWithHomeView({
    _i5.Key? key,
    void Function(_i4.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(HomeViewRoute(key: key), onFailure: onFailure);
  }

  Future<dynamic> replaceWithStartupView({
    _i5.Key? key,
    void Function(_i4.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(StartupViewRoute(key: key), onFailure: onFailure);
  }
}
