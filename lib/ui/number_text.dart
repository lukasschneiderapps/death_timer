import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NumberText extends StatelessWidget {
  static final TextStyle numberTextStyle =
  TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 25);

  static final NumberFormat numberFormat = NumberFormat.decimalPattern();

  final int value;
  final String unit;

  NumberText(this.value, this.unit);

  @override
  Widget build(BuildContext context) {
    return Text("${numberFormat.format(value)} $unit", style: numberTextStyle);
  }
}