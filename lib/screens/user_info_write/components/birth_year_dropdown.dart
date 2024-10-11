import 'package:flutter/material.dart';

class BirthYearDropdown extends StatelessWidget {
  final int? selectedYear; // 선택된 생년
  final Function(int?) onChanged; // 생년 변경 시 호출될 콜백

  BirthYearDropdown({
    required this.selectedYear,
    required this.onChanged,
  });

  final List<int> years = List.generate(
    DateTime.now().year - 1960 + 1, // 1960년부터 현재 연도까지의 리스트 생성
        (index) => 1960 + index,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey), // 테두리 색상
      ),
      child: DropdownButton<int>(
        hint: Text('생년 선택'),
        value: selectedYear,
        isExpanded: true, // 드롭다운 버튼을 확장
        items: years.map((year) {
          return DropdownMenuItem<int>(
            value: year,
            child: Center(child: Text(year.toString())), // 텍스트 중앙 정렬
          );
        }).toList(),
        onChanged: onChanged, // 콜백 사용
        underline: SizedBox(), // 기본 언더라인 제거
      ),
    );
  }
}
