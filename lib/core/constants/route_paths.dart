import 'package:death_timer/ui/views/main_view.dart';
import 'package:death_timer/ui/views/setup_view.dart';
import 'package:death_timer/ui/views/splash_view.dart';
import 'package:flutter/cupertino.dart';

class RoutePaths {
  static const String splash = "/";
  static const String setup = "/setup";
  static const String main = "/main";

  static final Map<String, WidgetBuilder> routes = {
    splash: (_) => SplashView(),
    setup: (_) => SetupView(),
    main: (_) => MainView()
  };

}