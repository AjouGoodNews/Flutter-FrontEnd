import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goodnews/screens/search/components/custom_search_bar.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_font.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  String searchQuery = ''; // 검색어 상태 저장

  void _onSearchQueryChanged(String query) {
    setState(() {
      searchQuery = query; // 검색어 업데이트
    });
  }

  final List<Map<String, String>> recentSearchQueries = [
    {'keyword': '네이버', 'date': '09.21'},
    {'keyword': '하나은행', 'date': '09.16'},
    {'keyword': '생성형 AI', 'date': '09.14'},
    {'keyword': '투자유치', 'date': '09.01'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('검색', style: CustomTextStyle.body1), // AppBar 제목 설정
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
              padding: EdgeInsets.symmetric(horizontal: defaultGapM * 2, vertical: defaultGapL * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSearchBar(
                    searchQuery: searchQuery, // 검색어 전달
                    onChanged: _onSearchQueryChanged, // 검색어 변경 시 호출될 콜백
                  ),

                  const Gap(defaultGapL * 2),

                  Text('검색기록', style: CustomTextStyle.title3),
                  const Gap(defaultGapL),
                  Expanded(
                    child: ListView.builder(
                      itemCount: recentSearchQueries.length,
                      itemBuilder: (context, index) {
                        final button = recentSearchQueries[index];
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(button['keyword']!, style: CustomTextStyle.body3.apply(color: darkGray)),
                                Text(button['date']!, style: CustomTextStyle.body3.apply(color: darkGray)),
                              ],
                            ),
                            const Gap(defaultGapS), // 각 항목 사이에 갭 추가
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}