import 'package:death_timer/core/constants/route_paths.dart';
import 'package:death_timer/core/viewmodels/setup_view_model.dart';
import 'package:death_timer/ui/widgets/base_widget.dart';
import 'package:death_timer/ui/widgets/square_text_field.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/medium_text.dart';

class SetupView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SetupViewState();
}

class SetupViewState extends State<SetupView>
    with SingleTickerProviderStateMixin {
  TextEditingController _ageInputController = TextEditingController();

  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: SetupViewModel(localStorageService: Provider.of(context)),
      builder: (BuildContext context, SetupViewModel model, _) {
        return Scaffold(
            backgroundColor: Colors.deepPurple,
            body: SafeArea(
              child: Container(
                  padding: EdgeInsets.all(36),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              MediumText(
                                  "Select your date of birth..", Colors.white),
                              SizedBox(height: 16),
                              RaisedButton(
                                shape: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(0)),
                                color: Colors.white,
                                onPressed: () => _showSelectBirthdayDialog(model),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: MediumText(
                                      model.selectedDateOfBirth == null
                                          ? 'Select date'
                                          : DateFormat('dd/MM/yyyy')
                                              .format(model.selectedDateOfBirth),
                                      Colors.deepPurple),
                                ),
                              ),
                              SizedBox(height: 48),
                              MediumText(
                                  "Estimate how old you will get, in years..",
                                  Colors.white),
                              SizedBox(height: 16),
                              SquareTextField(
                                  inputController: _ageInputController),
                              SizedBox(height: 25),
                            ]),
                      ),
                      Positioned(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: MaterialButton(
                              shape: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(0)),
                              color: Colors.white,
                              disabledColor: Colors.white12,
                              onPressed: () {
                                _finishButtonPressed(model);
                              },
                              child: Text("Finish",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple))),
                        ),
                      )
                    ],
                  )),
            ));
      },
    );
  }

  _finishButtonPressed(SetupViewModel model) async {
    if (model.isInputValid(_ageInputController.text)) {
      // Save data
      await model.saveDataToPreferences(
          model.selectedDateOfBirth, int.parse(_ageInputController.text));

      // Navigate to main page
      Navigator.pushReplacementNamed(context, RoutePaths.main);
    } else {
      _showInvalidInputDialog();
    }
  }

  _showInvalidInputDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Error"),
              content: Text("Invalid input"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Close"))
              ]);
        });
  }

  _showSelectBirthdayDialog(SetupViewModel model) async {
    final DateTime picked = await showDatePicker(
        builder: (BuildContext context, Widget child) {
          _controller.reset();
          _controller.forward();
          return AnimatedBuilder(
              animation: _controller,
              child: child,
              builder: (BuildContext context, Widget child) {
                return Opacity(
                  opacity: _controller.value,
                  child: Transform.scale(
                    scale: _controller.value,
                    child: child,
                  ),
                );
              });
        },
        context: context,
        initialDate: model.selectedDateOfBirth == null
            ? Jiffy(DateTime.now()).subtract(years: 20)
            : model.selectedDateOfBirth,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != model.selectedDateOfBirth)
      setState(() {
        model.selectedDateOfBirth = picked;
      });
  }
}
