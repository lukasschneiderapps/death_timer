import 'package:death_timer/core/constants/route_paths.dart';
import 'package:death_timer/core/viewmodels/main_view_model.dart';
import 'package:death_timer/ui/widgets/base_widget.dart';
import 'package:death_timer/utils/date_utils.dart';
import 'package:death_timer/ui/widgets/number_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  MainViewModel model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Initialize model and start rebuilding loop
    model = MainViewModel(localStorageService: Provider.of(context));
    model.startRebuildingLoop();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: model,
      builder: (BuildContext context, MainViewModel model, _) {
        return Scaffold(
            appBar: AppBar(
                elevation: 0,
                actions: [
                  InkWell(
                    customBorder: CircleBorder(),
                    onTap: () => Navigator.pushReplacementNamed(
                        context, RoutePaths.setup),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.edit),
                    ),
                  )
                ],
                centerTitle: true,
                title: Text("Death Timer",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 28))),
            backgroundColor: Colors.white,
            body: SafeArea(
                child: Container(
                    color: Colors.deepPurple,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, top: 16, right: 24, bottom: 24),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: model.timeLeftToLive == null
                                  ? [
                                      // Loading data
                                      Center(
                                          child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
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
                                                  model.dateOfDeath)
                                              .years,
                                          "years"),
                                      SizedBox(height: 5),
                                      NumberText(
                                          DateUtils.calculateMonthsFromNowUntil(
                                              model.dateOfDeath),
                                          "months"),
                                      SizedBox(height: 5),
                                      NumberText(
                                          model.timeLeftToLive.inDays ~/ 7, "weeks"),
                                      SizedBox(height: 5),
                                      NumberText(model.timeLeftToLive.inDays, "days"),
                                      SizedBox(height: 5),
                                      NumberText(
                                          model.timeLeftToLive.inHours, "hours"),
                                      SizedBox(height: 5),
                                      NumberText(
                                          model.timeLeftToLive.inMinutes, "minutes"),
                                      SizedBox(height: 5),
                                      NumberText(
                                          model.timeLeftToLive.inSeconds, "seconds"),
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
                                          model.dateOfBirth.toString(
                                                  DateUtils.DATE_FORMAT) +
                                              " - " +
                                              model.dateOfDeath.toString(
                                                  DateUtils.DATE_FORMAT),
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
                                                    value:
                                                    model.livedPercentage / 100.0,
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                            Colors.pink)),
                                              ),
                                              Center(
                                                  child: Text(
                                                      "${model.livedPercentage}%",
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
      },
    );
  }
}
