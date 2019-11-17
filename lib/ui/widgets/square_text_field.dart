import 'package:flutter/material.dart';

class SquareTextField extends StatelessWidget {
  final TextEditingController inputController;

  const SquareTextField({
    Key key,
    @required this.inputController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: inputController,
        cursorColor: Colors.deepPurple,
        keyboardType: TextInputType.number,
        style: TextStyle(
            color: Colors.deepPurple, fontSize: 28),
        decoration: InputDecoration(
            errorStyle:
            TextStyle(color: Colors.white),
            filled: true,
            focusColor: Colors.white,
            fillColor: Colors.white,
            hoverColor: Colors.white,
            enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.white),
                borderRadius:
                BorderRadius.circular(0)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.white),
                borderRadius:
                BorderRadius.circular(0)),
            border: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.white),
                borderRadius:
                BorderRadius.circular(0))));
  }
}