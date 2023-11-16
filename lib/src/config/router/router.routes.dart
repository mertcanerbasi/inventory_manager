// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteMapConfigGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';
import 'package:inventory_manager/src/presentation/views/create_qr_view/create_qr_view.dart';
import 'package:inventory_manager/src/presentation/views/home_view/home_view.dart';
import 'package:inventory_manager/src/presentation/views/app_settings_view/app_settings_view.dart';
import 'package:inventory_manager/src/presentation/views/root_view/root_view.dart';
import 'package:inventory_manager/src/presentation/views/login_view/login_view.dart';
import 'package:inventory_manager/src/presentation/views/splash_view/splash_view.dart';

class RouteMaps {
  static const String createQrViewRoute = "/create_qr_view";
  static const String homeViewRoute = "/home_view";
  static const String appSettingsViewRoute = "/app_settings_view";
  static const String root = "/";
  static const String loginViewRoute = "login";
  static const String splashViewRoute = "splash";
}

Map<String, RouteModel> get routes => _routes;
final Map<String, RouteModel> _routes = {
  RouteMaps.createQrViewRoute: RouteModel(
    (_) => const CreateQrView(),
  ),
  RouteMaps.homeViewRoute: RouteModel(
    (_) => const HomeView(),
  ),
  RouteMaps.appSettingsViewRoute: RouteModel(
    (_) => const AppSettingsView(),
    fullscreenDialog: true,
  ),
  RouteMaps.root: RouteModel(
    (_) => const RootView(),
  ),
  RouteMaps.loginViewRoute: RouteModel(
    (_) => const LoginView(),
  ),
  RouteMaps.splashViewRoute: RouteModel(
    (_) => const SplashView(),
  ),
};
Route? $onGenerateRoute(RouteSettings routeSettings,
        {String? Function(String routeName)? redirect}) =>
    onGenerateRouteWithRoutesSettings(
      routeSettings,
      routes,
      redirect: redirect,
    );

class CreateQrViewRoute extends BaseRoute {
  CreateQrViewRoute() : super(RouteMaps.createQrViewRoute);
  static const String name = RouteMaps.createQrViewRoute;
}

class HomeViewRoute extends BaseRoute {
  HomeViewRoute() : super(RouteMaps.homeViewRoute);
  static const String name = RouteMaps.homeViewRoute;
}

class AppSettingsViewRoute extends BaseRoute {
  AppSettingsViewRoute() : super(RouteMaps.appSettingsViewRoute);
  static const String name = RouteMaps.appSettingsViewRoute;
}

class RootViewRoute extends BaseRoute {
  RootViewRoute() : super(RouteMaps.root);
  static const String name = RouteMaps.root;
}

class LoginViewRoute extends BaseRoute {
  LoginViewRoute() : super(RouteMaps.loginViewRoute);
  static const String name = RouteMaps.loginViewRoute;
}

class SplashViewRoute extends BaseRoute {
  SplashViewRoute() : super(RouteMaps.splashViewRoute);
  static const String name = RouteMaps.splashViewRoute;
}
