import 'package:death_timer/data/data.dart';
import 'package:death_timer/routes/main_route.dart';
import 'package:death_timer/routes/setup_route.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class NavigationUtils {

  static void navigateToMainRoute(BuildContext context) {
    Navigator.pushReplacementNamed(context, mainRoute);
  }

  static void navigateToSetupOrMainRoute(BuildContext context) async {
    DateTime dateTime = await Data.getDateOfBirth();
    Navigator.pushReplacementNamed(
        context, dateTime == null ? setupRoute : mainRoute);
  }

  static void navigateToSetupRoute(BuildContext context) {
    Navigator.pushReplacementNamed(
        context,
        setupRoute
    );
  }

}
