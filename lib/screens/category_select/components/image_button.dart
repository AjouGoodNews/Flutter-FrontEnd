import 'package:flutter/material.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_font.dart';

class ImageButton extends StatelessWidget {
  final String imageUrl; // 이미지 경로
  final String label; // 레이블 추가
  final VoidCallback onPressed;

  ImageButton({
    required this.imageUrl,
    required this.label, // 레이블 매개변수 추가
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
        children: [
          Container(
            width: 94,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Image.asset(
                    imageUrl, // 로컬 이미지 경로 사용
                    fit: BoxFit.cover,
                    width: 94,
                    height: 90,
                  ),
                  // 딤 처리
                  Container(
                    color: Colors.black.withOpacity(0.47), // 반투명 검정색
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: defaultGapS / 2), // 이미지와 레이블 사이의 간격
          Text(
            label,
            style: CustomTextStyle.caption1,
          ),
        ],
      ),
    );
  }
}
