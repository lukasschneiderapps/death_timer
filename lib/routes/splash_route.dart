import 'package:death_timer/data/data.dart';
import 'package:death_timer/routes/setup_route.dart';
import 'package:flutter/material.dart';

import 'main_route.dart';

class SplashRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashRouteState();
}

class SplashRouteState extends State<SplashRoute> {
  @override
  void initState() {
    super.initState();
    navigateToSetupOrMainRoute();
  }

  void navigateToSetupOrMainRoute() async {
    DateTime dateTime = await Data.getDateOfBirth();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => dateTime == null ? SetupRoute() : MainRoute()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple, body: SafeArea(child: Container()));
  }
}
