import 'package:flutter/material.dart';
import 'package:goodnews/themes/custom_color.dart';

class CustomIconButtonTheme {
  static IconButtonThemeData customIconButtonThemeData() {
    return IconButtonThemeData(
      style: ButtonStyle(
        iconSize: WidgetStateProperty.all(24),
        iconColor: WidgetStateProperty.all(black),
      ),
    );
  }
}