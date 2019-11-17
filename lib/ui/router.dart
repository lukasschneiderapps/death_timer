import 'package:death_timer/routes/main_route.dart';
import 'package:death_timer/routes/setup_route.dart';
import 'package:death_timer/routes/splash_route.dart';
import 'package:death_timer/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Router {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => SplashRoute());
      case setupRoute:
        return MaterialPageRoute(builder: (_) => SetupRoute());
      case mainRoute:
        return MaterialPageRoute(builder: (_) => MainRoute());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Center(
                    child: Text("Error: unknown route ${settings.name}"))));
    }
  }
}
