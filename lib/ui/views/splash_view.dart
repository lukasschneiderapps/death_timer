import 'package:death_timer/core/constants/route_paths.dart';
import 'package:death_timer/core/viewmodels/setup_view_model.dart';
import 'package:death_timer/core/viewmodels/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    navigateToAppropriateScreen();
  }

  navigateToAppropriateScreen() async {
    SplashViewModel model = SplashViewModel(localStorageService: Provider.of(context));
    Navigator.pushReplacementNamed(context, await model.isDataSet() ? RoutePaths.main : RoutePaths.setup);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple, body: SafeArea(child: Container()));
  }

}
