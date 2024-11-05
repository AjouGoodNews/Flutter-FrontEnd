import 'package:flutter/material.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_font.dart';

class CategorySelectButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  CategorySelectButton({
    required this.label,
    this.isSelected = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // 버튼 크기 조정
      // width: 120, // width를 늘려 레이블이 잘리지 않도록
      // height: 42,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(color: isSelected ? yellow : primary), // 선택된 상태에 따라 텍스트 색상 변경
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? primary : Colors.white, // 선택된 상태에 따라 배경색 변경
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // 라운드 모서리
            side: BorderSide(
              // color: isSelected ? primary : Colors.grey, // 테두리 색상 지정
              color: primary, // 테두리 색상 지정
              width: 1, // 테두리 두께
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 39, vertical: 12.5), // padding 조정
          textStyle: CustomTextStyle.body1,
        ),
      ),
    );
  }
}
