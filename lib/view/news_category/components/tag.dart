import 'package:flutter/material.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_font.dart';

class Tag extends StatelessWidget {
  final String label;

  Tag({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11, vertical: 5), // padding 조정
      decoration: BoxDecoration(
        color: primary, // 배경색 설정
        borderRadius: BorderRadius.circular(15), // 라운드 모서리
      ),
      child: Text(
        label,
        style: CustomTextStyle.caption2.apply(color: yellow), // 텍스트 색상
      ),
    );
  }
}
