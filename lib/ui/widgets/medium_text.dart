
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MediumText extends StatelessWidget {
  final String _text;
  final Color _color;

  const MediumText(String text, Color color) :
        _text = text,
  _color = color;

  @override
  Widget build(BuildContext context) {
    return Text(
        _text,
        style: TextStyle(
            color: _color,
            fontSize: 28,
            fontStyle: FontStyle.normal));
  }
}