import 'package:death_timer/data/data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainRouteState();
}

class MainRouteState extends State<MainRoute> {
  static const int minutesPerYear = 525600;

  TextStyle numberTextStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 25);

  NumberFormat numberFormat = NumberFormat.decimalPattern();

  Duration timeLeftToLiveDuration;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {
    DateTime dateOfBirth = await Data.getDateOfBirth();
    int estimatedAge = await Data.getEstimatedAge();

    Duration lifeDuration = Duration(minutes: estimatedAge * minutesPerYear);
    Duration alreadyLivedDuration = dateOfBirth.difference(DateTime.now());

    setState(() {
      timeLeftToLiveDuration = Duration(
          minutes: lifeDuration.inMinutes - alreadyLivedDuration.inMinutes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Death Timer",
                style: TextStyle(fontWeight: FontWeight.w600))),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                        color: Colors.deepPurple,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: timeLeftToLiveDuration == null
                                  ? []
                                  : [
                                      Text(
                                        "You'll die in..",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "${numberFormat.format((timeLeftToLiveDuration.inMinutes / minutesPerYear).round())} years",
                                        style: numberTextStyle,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "${numberFormat.format((timeLeftToLiveDuration.inMinutes / minutesPerYear * 12.0).round())} months",
                                        style: numberTextStyle,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "${numberFormat.format((timeLeftToLiveDuration.inMinutes / minutesPerYear * 52.143).round())} weeks",
                                        style: numberTextStyle,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "${numberFormat.format(timeLeftToLiveDuration.inDays)} days",
                                        style: numberTextStyle,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "${numberFormat.format(timeLeftToLiveDuration.inHours)} hours",
                                        style: numberTextStyle,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "${numberFormat.format(timeLeftToLiveDuration.inMinutes)} minutes",
                                        style: numberTextStyle,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "${numberFormat.format(timeLeftToLiveDuration.inSeconds)} seconds",
                                        style: numberTextStyle,
                                      ),
                                    ]),
                        )),
                  ],
                ))));
  }
}
