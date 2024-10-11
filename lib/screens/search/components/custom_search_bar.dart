import 'package:flutter/material.dart';
import 'package:goodnews/themes/custom_color.dart';

class CustomSearchBar extends StatelessWidget {
  final String searchQuery; // 검색어 상태
  final Function(String) onChanged; // 검색어 변경 시 호출될 콜백

  CustomSearchBar({
    required this.searchQuery,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primary), // 파란색 테두리
        borderRadius: BorderRadius.circular(117), // 라운드 설정
      ),
      child: TextField(
        onChanged: onChanged, // 검색어 변경 시 호출될 콜백
        decoration: InputDecoration(
          hintText: '(ex- 기사제목, 산업, 기업)', // 플레이스홀더 텍스트
          hintStyle: TextStyle(color: Colors.grey), // 플레이스홀더 색상
          border: InputBorder.none, // 기본 테두리 제거
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // 내부 여백
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 20), // 아이콘 여백
            child: Icon(
              Icons.search, // 돋보기 아이콘
              color: primary, // 아이콘 색상
            ),
          ),
        ),
      ),
    );
  }
}
