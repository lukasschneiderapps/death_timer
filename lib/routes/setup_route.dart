import 'package:death_timer/data/data.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';

import 'main_route.dart';

class SetupRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SetupRouteState();
}

class SetupRouteState extends State<SetupRoute> {
  TextEditingController ageInputController = TextEditingController();

  DateTime _selectedDateOfBirth;

  bool _validAgeInput = true;

  @override
  void initState() {
    super.initState();
    ageInputController.addListener(() {
      _verifyAgeInput();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text("Welcome!",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28))),
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainRoute()),
    );
  }

  _verifyAgeInput() {
    bool valid = _isAgeInputValid();
    setState(() {
      _validAgeInput = valid;
    });
  }

  bool _isAgeInputValid() {
    String input = ageInputController.text;

    // Numeric
    try {
      int.parse(input);
    } catch (Exception) {
      return false;
    }

    // Positive
    if (!(int.parse(input) > 0)) return false;

    // In Range
    if (int.parse(input) > 1000) return false;

    // Valid
    return true;
  }

  bool _isInputValid() {
    return _selectedDateOfBirth != null && _validAgeInput;
  }

  Future<Null> _selectBirthday() async {
    final DateTime picked = await showDatePicker(
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
