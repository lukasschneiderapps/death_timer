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

  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {
    DateTime dateOfBirth = await Data.getDateOfBirth();
    int estimatedAge = await Data.getEstimatedAge();
    Duration tmpTimeLeftToLiveDuration =
        await DateUtils.calculateTimeLeftToLiveDuration(
            dateOfBirth, estimatedAge);

    setState(() {
      timeLeftToLiveDuration = tmpTimeLeftToLiveDuration;
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
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25),
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
                                    ]),
                        )),
                  ],
                ))));
  }
}
