import 'package:flutter/material.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_font.dart';

class GenderButton extends StatelessWidget {
  final String label; // 버튼에 표시할 텍스트
  final bool isSelected; // 버튼 선택 여부
  final VoidCallback onPressed; // 버튼 클릭 시 실행할 콜백

  GenderButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? lightPrimary : Colors.white, // 선택된 경우 파란색, 그렇지 않으면 회색
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? primary : gray, // 진한 회색 테두리
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 46.5),
        child: Text(
          label,
          style: CustomTextStyle.body1.apply(color: isSelected ? primary : gray)
        ),
      ),
    );
  }
}
