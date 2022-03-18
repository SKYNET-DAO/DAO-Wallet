import 'package:flutter/material.dart';

extension numEx on num {
  SizedBox get inRow => SizedBox(
        width: this.toDouble(),
      );
  SizedBox get inColumn => SizedBox(
        height: this.toDouble(),
      );
  Color get color => Color(this.toInt());
}

extension doubleEx on double {
  String awesome([int fractionDigits = 2]) {
    String s = this.toStringAsFixed(fractionDigits);
    while (s.endsWith("0")) s = s.substring(0, s.length - 1);
    if (s.endsWith(".")) s = s.substring(0, s.length - 1);
    return s;
  }
}
