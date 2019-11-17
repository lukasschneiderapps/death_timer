import 'package:death_timer/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class SplashRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashRouteState();
}

class SplashRouteState extends State<SplashRoute> {
  @override
  void initState() {
    super.initState();
    NavigationUtils.navigateToSetupOrMainRoute(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple, body: SafeArea(child: Container()));
  }
}
