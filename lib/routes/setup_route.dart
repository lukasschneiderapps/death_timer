import 'dart:math';

import 'package:death_timer/data/data.dart';
import 'package:death_timer/utils/input_validator.dart';
import 'package:death_timer/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';

import 'main_route.dart';

class SetupRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SetupRouteState();
}

class SetupRouteState extends State<SetupRoute>
    with SingleTickerProviderStateMixin {
  TextEditingController ageInputController = TextEditingController();

  DateTime _selectedDateOfBirth;

  AnimationController _controller;

  bool _validAgeInput = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    ageInputController.addListener(() {
      _verifyAgeInput();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          Text("Select your date of birth..",
                              style:
                                  TextStyle(fontSize: 26, color: Colors.white)),
                          SizedBox(height: 16),
                          RaisedButton(
                            shape: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(0)),
                            color: Colors.white,
                            onPressed: () => _selectBirthday(),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                  _selectedDateOfBirth == null
                                      ? 'Select date'
                                      : DateFormat('dd/MM/yyyy')
                                          .format(_selectedDateOfBirth),
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 28,
                                      fontStyle: FontStyle.normal)),
                            ),
                          ),
                          SizedBox(height: 48),
                          Text("Estimate how old you will get, in years..",
                              style:
                                  TextStyle(fontSize: 26, color: Colors.white)),
                          SizedBox(height: 16),
                          TextField(
                              controller: ageInputController,
                              cursorColor: Colors.deepPurple,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  color: Colors.deepPurple, fontSize: 28),
                              decoration: InputDecoration(
                                  errorText: (_validAgeInput ||
                                          ageInputController.text == "")
                                      ? null
                                      : "Invalid input",
                                  errorStyle: TextStyle(color: Colors.white),
                                  filled: true,
                                  focusColor: Colors.white,
                                  fillColor: Colors.white,
                                  hoverColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(0)),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(0)))),
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
                          onPressed: _isInputValid() ? _onFinishPressed : null,
                          child: Text("Finish",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple))),
                    ),
                  )
                ],
              )),
        ));
  }

  _onFinishPressed() async {
    // Save data
    await Data.saveDataToPreferences(
        _selectedDateOfBirth, int.parse(ageInputController.text));

    // Navigate to main page
    NavigationUtils.navigateToMainRoute(context);
  }

  _verifyAgeInput() {
    setState(() {
      _validAgeInput = InputValidator.isAgeInputValid(ageInputController.text);
    });
  }

  bool _isInputValid() {
    return _selectedDateOfBirth != null && _validAgeInput;
  }

  Future<Null> _selectBirthday() async {
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
        initialDate: _selectedDateOfBirth == null
            ? Jiffy(DateTime.now()).subtract(years: 20)
            : _selectedDateOfBirth,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != _selectedDateOfBirth)
      setState(() {
        _selectedDateOfBirth = picked;
      });
  }
}
