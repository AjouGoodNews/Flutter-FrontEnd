import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goodnews/view/scrap/components/category_group_button.dart';
import 'package:goodnews/view/search/components/custom_search_bar.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_font.dart';

import '../category/category_detail_screen.dart';

class ScrapScreen extends StatefulWidget {
  const ScrapScreen({super.key});

  @override
  State<ScrapScreen> createState() => _ScrapScreen();
}

class _ScrapScreen extends State<ScrapScreen> {
  String searchQuery = ''; // 검색어 상태 저장

  void _onSearchQueryChanged(String query) {
    setState(() {
      searchQuery = query; // 검색어 업데이트
    });
  }

  final List<Map<String, String>> categories = [
    {'label': '모든 기사', 'url': 'assets/images/categories/all.png', 'count': '45', 'category': 'ALL'},
    {'label': '정치', 'url': 'assets/images/categories/politics.png', 'count': '15', 'category': 'POLITICS'},
    {'label': '경제', 'url': 'assets/images/categories/economy.png', 'count': '13', 'category': 'ECONOMY'},
    {'label': '세계', 'url': 'assets/images/categories/world.png', 'count': '9', 'category': 'WORLD'},
    {'label': '테크', 'url': 'assets/images/categories/tech.png', 'count': '6', 'category': 'TECH'},
    {'label': '노동', 'url': 'assets/images/categories/labor.png', 'count': '4', 'category': 'LABOR'},
    {'label': '환경', 'url': 'assets/images/categories/environment.png', 'count': '3', 'category': 'ENVIRONMENT'},
    {'label': '인권', 'url': 'assets/images/categories/humanRights.png', 'count': '2', 'category': 'HUMAN_RIGHTS'},
    {'label': '문화', 'url': 'assets/images/categories/culture.png', 'count': '1', 'category': 'CULTURE'},
    {'label': '라이프', 'url': 'assets/images/categories/life.png', 'count': '0', 'category': 'LIFE'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('스크랩', style: CustomTextStyle.body1), // AppBar 제목 설정
        backgroundColor: primary, // AppBar 배경색 설정
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: lightPrimary
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: defaultGapL * 2), // 위쪽 패딩만 설정
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultGapM * 2),
                    child: Column(
                      children: [
                        Text('스크랩한 기사들 중 찾고 싶은 주제가 있나요?', style: CustomTextStyle.title3,),
                        const Gap(13),
                        CustomSearchBar(
                          searchQuery: searchQuery, // 검색어 전달
                          onChanged: _onSearchQueryChanged, // 검색어 변경 시 호출될 콜백
                          onSubmitted: (text) => {},
                        ),
                      ],
                    ),
                  ),

                  const Gap(defaultGapM * 2),

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 36), // 내부 패딩 설정
                      decoration: BoxDecoration(
                        color: Colors.white, // 배경색 흰색
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40), // 상단 왼쪽 모서리 라운드
                          topRight: Radius.circular(40), // 상단 오른쪽 모서리 라운드
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                alignment: Alignment.center, // 중앙 정렬
                                children: [
                                  // 밑줄 이미지
                                  Positioned(
                                    top: 20, // 텍스트 아래로 조정 (필요에 따라 값 변경)
                                    left: 60,
                                    child: Image.asset(
                                      'assets/images/scrap/custom-underline.png', // 밑줄 이미지 경로
                                      width: 190, // 이미지 너비 설정
                                      fit: BoxFit.cover, // 이미지 크기 조정
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: CustomTextStyle.title3.copyWith(color: Colors.black), // 기본 텍스트 스타일
                                      children: [
                                        TextSpan(text: '지금까지 ', style: TextStyle(color: Colors.black)), // 첫 부분
                                        TextSpan(text: '45개', style: TextStyle(color: primary)), // 색상을 다르게 할 부분
                                        TextSpan(text: '의 기사를 스크랩하셨네요!', style: TextStyle(color: Colors.black)), // 나머지 부분
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text('수정', style: CustomTextStyle.caption2.apply(color: darkGray)),
                            ],
                          ),
                          const Gap(defaultGapS),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // 2개 열
                                crossAxisSpacing: defaultGapS * 2, // 열 사이 간격
                                mainAxisSpacing: defaultGapS, // 행 사이 간격
                              ),
                              itemCount: categories.length, // 버튼 수
                              itemBuilder: (context, index) {
                                return CategoryGroupButton(
                                  imageUrl: categories[index]['url']!, // URL
                                  label: categories[index]['label']!, // 레이블
                                  count: categories[index]['count']!,
                                  onPressed: () {
                                    final label = categories[index]['label'];
                                    final category = categories[index]['category'];

                                    print('$label $category 클릭됨'); // 클릭 시 레이블 출력
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => NewsCategoryDetailScreen(
                                          categoryLabel: label,
                                          category: category,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}