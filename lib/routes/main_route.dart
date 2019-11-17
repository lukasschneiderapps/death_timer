import 'dart:async';

import 'package:death_timer/data/data.dart';
import 'package:death_timer/routes/setup_route.dart';
import 'package:death_timer/utils/constants.dart';
import 'package:death_timer/utils/date_utils.dart';
import 'package:death_timer/ui/number_text.dart';
import 'package:death_timer/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_machine/time_machine.dart';

class MainRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainRouteState();
}

class MainRouteState extends State<MainRoute> {
  Time timeLeftToLive;
  Instant dateOfBirth;
  Instant dateOfDeath;
  int livedPercentage;

  @override
  void initState() {
    super.initState();
    _startRebuildingLoop();
  }

  _startRebuildingLoop() {
    Future.delayed(Duration(seconds: 1), () async {
      DateTime dateOfBirthDateTime = await Data.getDateOfBirth();
      int estimatedAge = await Data.getEstimatedAge();
      Time lifeTime =
          DateUtils.calculateLifeTime(dateOfBirthDateTime, estimatedAge);

      setState(() {
        dateOfBirth = Instant.dateTime(dateOfBirthDateTime);
        timeLeftToLive = DateUtils.calculateTimeLeftToLive(
            dateOfBirthDateTime, estimatedAge);
        dateOfDeath = DateUtils.calculateDateOfDeath(timeLeftToLive);
        livedPercentage =
            DateUtils.calculateLivedPercentage(timeLeftToLive, lifeTime);
      });

      _startRebuildingLoop();
    });
  }

  _onEditClicked() {
    NavigationUtils.navigateToSetupRoute(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
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
                color: Colors.deepPurple,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 24, top: 16, right: 24, bottom: 24),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: timeLeftToLive == null
                              ? [
                                  // Loading data
                                  Center(
                                      child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white)))
                                ]
                              : [
                                  // Data loaded
                                  Chip(
                                    padding: EdgeInsets.all(4),
                                    backgroundColor: Colors.white,
                                    label: Text(
                                      "You'll die in..",
                                      style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 30),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  NumberText(
                                      DateUtils.calculatePeriodFromNowUntil(
                                              dateOfDeath)
                                          .years,
                                      "years"),
                                  SizedBox(height: 5),
                                  NumberText(
                                      DateUtils.calculateMonthsFromNowUntil(
                                          dateOfDeath),
                                      "months"),
                                  SizedBox(height: 5),
                                  NumberText(
                                      timeLeftToLive.inDays ~/ 7, "weeks"),
                                  SizedBox(height: 5),
                                  NumberText(timeLeftToLive.inDays, "days"),
                                  SizedBox(height: 5),
                                  NumberText(timeLeftToLive.inHours, "hours"),
                                  SizedBox(height: 5),
                                  NumberText(
                                      timeLeftToLive.inMinutes, "minutes"),
                                  SizedBox(height: 5),
                                  NumberText(
                                      timeLeftToLive.inSeconds, "seconds"),
                                  SizedBox(height: 32),
                                  Chip(
                                    padding: EdgeInsets.all(4),
                                    backgroundColor: Colors.white,
                                    label: Text(
                                      "Life span:",
                                      style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 30),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                      dateOfBirth
                                              .toString(DateUtils.DATE_FORMAT) +
                                          " - " +
                                          dateOfDeath
                                              .toString(DateUtils.DATE_FORMAT),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w200,
                                          fontSize: 25)),
                                  SizedBox(height: 16),
                                  SizedBox(
                                      height: 50,
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: LinearProgressIndicator(
                                                value: livedPercentage / 100.0,
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.pink)),
                                          ),
                                          Center(
                                              child: Text("$livedPercentage%",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                      fontSize: 28))),
                                        ],
                                      )),
                                ]),
                    ),
                  ],
                ))));
  }
}
