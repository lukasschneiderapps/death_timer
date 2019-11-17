import 'package:death_timer/provider_setup.dart';
import 'package:death_timer/core/constants/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        initialRoute: RoutePaths.splash,
        routes: RoutePaths.routes,
        title: 'Death Timer',
        theme: ThemeData(fontFamily: "Raleway", primarySwatch: Colors.deepPurple)
      ),
    );
  }
}
