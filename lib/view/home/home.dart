import 'package:flutter/material.dart';
import 'package:goodnews/view/news_category/news_category_screen.dart'; // 카테고리 화면 임포트
import 'package:goodnews/view/news_today/news_today_screen.dart'; // 오늘의 이슈 화면 임포트
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_font.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _selectedNavIndex = 0; // 현재 선택된 내비게이션 인덱스

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedNavIndex = index; // 내비게이션 아이템 선택
      _pageController.jumpToPage(index); // 해당 페이지로 이동
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedNavIndex = index; // 페이지가 변경될 때 선택된 내비게이션 인덱스 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('홈', style: CustomTextStyle.body1), // AppBar 제목 설정
        backgroundColor: primary, // AppBar 배경색 설정
      ),
      body: Column(
        children: [
          // 상단 내비게이션
          Container(
            color: beige, // 상단 내비게이션 배경색 설정
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () => _onNavItemTapped(0),
                        child: Text(
                          '주제별',
                          style: TextStyle(
                            color: _selectedNavIndex == 0 ? primary : darkGray,
                          ),
                        ),
                      ),
                      if (_selectedNavIndex == 0) // 선택된 탭에 밑줄 추가
                        Container(
                          height: 3,
                          width: double.infinity, // 전체 너비 사용
                          color: primary, // 밑줄 색상
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () => _onNavItemTapped(1),
                        child: Text(
                          '오늘의 이슈',
                          style: TextStyle(
                            color: _selectedNavIndex == 1 ? primary : darkGray,
                          ),
                        ),
                      ),
                      if (_selectedNavIndex == 1) // 선택된 탭에 밑줄 추가
                        Container(
                          height: 3,
                          width: double.infinity, // 전체 너비 사용
                          color: primary, // 밑줄 색상
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 페이지 뷰
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged, // 페이지 변경 시 호출
              children: [
                NewsCategoryScreen(), // 카테고리 화면
                NewsTodayScreen(), // 오늘의 이슈 화면
              ],
            ),
          ),
        ],
      ),
    );
  }
}
