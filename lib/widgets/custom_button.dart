import 'package:flutter/material.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_font.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  CustomButton({
    required this.label,
    required this.onPressed,
    this.backgroundColor = primary, // 기본 배경색
    this.textColor = yellow, // 기본 글자색
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(color: textColor),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // 배경색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // 라운드 모서리
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          textStyle: CustomTextStyle.body1
        ),
      ),
    );
  }
}
