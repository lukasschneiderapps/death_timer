import 'dart:async';

import 'package:death_timer/data/data.dart';
import 'package:death_timer/routes/setup_route.dart';
import 'package:death_timer/ui/date_utils.dart';
import 'package:death_timer/ui/number_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainRouteState();
}

class MainRouteState extends State<MainRoute> {
  Duration timeLeftToLiveDuration;
  DateTime dateOfDeath;
  int livedPercentage;

  @override
  void initState() {
    super.initState();
    startRebuildingLoop();
  }

  startRebuildingLoop() async {
    Timer.periodic(Duration(seconds: 1), (Timer t) async {
      DateTime dateOfBirth = await Data.getDateOfBirth();
      int estimatedAge = await Data.getEstimatedAge();
      Duration tmpTimeLeftToLiveDuration =
          await DateUtils.calculateTimeLeftToLiveDuration(
              dateOfBirth, estimatedAge);

      setState(() {
        timeLeftToLiveDuration = tmpTimeLeftToLiveDuration;
        dateOfDeath = DateUtils.calculateDateOfDeath(timeLeftToLiveDuration);
        livedPercentage = (100 *
                (1 -
                    tmpTimeLeftToLiveDuration.inMinutes /
                        (estimatedAge * DateUtils.minutesPerYear)))
            .round();
      });
    });
  }

  _onEditClicked() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SetupRoute()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              InkWell(
                customBorder: CircleBorder(),
                onTap: _onEditClicked,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.edit),
                ),
              )
            ],
            centerTitle: true,
            title: Text("Death Timer",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28))),
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
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: timeLeftToLiveDuration == null
                                  ? []
                                  : [
                                      SizedBox(
                                          height: 50,
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                child: LinearProgressIndicator(
                                                    value:
                                                        livedPercentage / 100.0,
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                            Colors.pink)),
                                              ),
                                              Center(
                                                  child: Text(
                                                      "$livedPercentage%",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 28))),
                                            ],
                                          )),
                                      SizedBox(height: 30),
                                      Text(
                                        "You'll die in..",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 30),
                                      ),
                                      SizedBox(height: 10),
                                      NumberText(
                                          timeLeftToLiveDuration.inMinutes ~/
                                              DateUtils.minutesPerYear,
                                          "years"),
                                      SizedBox(height: 5),
                                      NumberText(
                                          (timeLeftToLiveDuration.inMinutes /
                                                  DateUtils.minutesPerYear *
                                                  12.0)
                                              .toInt(),
                                          "months"),
                                      SizedBox(height: 5),
                                      NumberText(
                                          (timeLeftToLiveDuration.inMinutes /
                                                  DateUtils.minutesPerYear *
                                                  52.143)
                                              .toInt(),
                                          "weeks"),
                                      SizedBox(height: 5),
                                      NumberText(timeLeftToLiveDuration.inDays,
                                          "days"),
                                      SizedBox(height: 5),
                                      NumberText(timeLeftToLiveDuration.inHours,
                                          "hours"),
                                      SizedBox(height: 5),
                                      NumberText(
                                          timeLeftToLiveDuration.inMinutes,
                                          "minutes"),
                                      SizedBox(height: 5),
                                      NumberText(
                                          timeLeftToLiveDuration.inSeconds,
                                          "seconds"),
                                      SizedBox(height: 32),
                                      Text(
                                        "Date of death:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 30),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                          DateFormat("dd/MM/yyyy")
                                              .format(dateOfDeath),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w200,
                                              fontSize: 25))
                                    ]),
                        )),
                  ],
                ))));
  }
}
