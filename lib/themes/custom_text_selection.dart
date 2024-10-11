import 'package:flutter/material.dart';
import 'package:goodnews/themes/custom_color.dart';

class CustomTextSelectionTheme {
  static TextSelectionThemeData customTextSelectionThemeData() {
    return const TextSelectionThemeData(
      cursorColor: black,
      selectionColor: lightGray,
      selectionHandleColor: Colors.transparent,
    );
  }
}