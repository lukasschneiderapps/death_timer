import 'package:death_timer/routes/main_route.dart';
import 'package:death_timer/routes/setup_route.dart';
import 'package:death_timer/routes/splash_route.dart';
import 'package:flutter/cupertino.dart';

const String splashRoute = "/";
const String setupRoute = "/setup";
const String mainRoute = "/main";

final Map<String, WidgetBuilder> routes = {
  splashRoute: (_) => SplashRoute(),
  setupRoute: (_) => SetupRoute(),
  mainRoute: (_) => MainRoute()
};