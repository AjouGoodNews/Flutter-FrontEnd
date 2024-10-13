import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_font.dart';

class CategoryGroupButton extends StatelessWidget {
  final String imageUrl; // 이미지 경로
  final String label; // 레이블 추가
  final String count;
  final VoidCallback onPressed;

  CategoryGroupButton({
    required this.imageUrl,
    required this.label, // 레이블 매개변수 추가
    required this.count,
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
            width: 145,
            height: 103,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.47), // 딤 처리
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Image.asset(
                    imageUrl, // 로컬 이미지 경로 사용
                    fit: BoxFit.cover,
                    width: 145, // Container의 너비에 맞춤
                    height: 103, // Container의 높이에 맞춤
                  ),
                  // 딤 처리 추가
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.47), // 딤 처리 색상
                    ),
                  ),
                  // 버튼 텍스트를 여기에 추가
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      // padding: EdgeInsets.symmetric(vertical: 8), // 패딩 추가
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            label,
                            style: CustomTextStyle.body4.copyWith(color: Colors.white), // 텍스트 색상 변경
                          ),
                          const Gap(4),
                          Text(
                            count + '개',
                            style: CustomTextStyle.caption1.copyWith(color: Colors.white), // 텍스트 색상 변경
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
