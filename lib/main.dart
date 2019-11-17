import 'package:death_timer/routes/main_route.dart';
import 'package:death_timer/routes/setup_route.dart';
import 'package:death_timer/routes/splash_route.dart';
import 'package:death_timer/utils/constants.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: splashRoute,
      routes: routes,
      title: 'Death Timer',
      theme: ThemeData(fontFamily: "Raleway", primarySwatch: Colors.deepPurple)
    );
  }
}
