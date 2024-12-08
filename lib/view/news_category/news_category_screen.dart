import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goodnews/model/news/news_article.dart';
import 'package:goodnews/repository/category/category_repository.dart';
import 'package:goodnews/repository/home/home_repository.dart';
import 'package:goodnews/view/news_category/components/category_select_button.dart';
import 'package:goodnews/view/news_category/components/news_card.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_font.dart';
import 'package:goodnews/view/news_detail/news_detail_screen.dart';

import '../../enums/news_category.dart';

class NewsCategoryScreen extends StatefulWidget {
  const NewsCategoryScreen({super.key});

  @override
  State<NewsCategoryScreen> createState() => _NewsCategoryScreen();
}

class _NewsCategoryScreen extends State<NewsCategoryScreen> {
  int _selectedCategoryIndex = 0;
  bool _isSummary = true;
  final HomeRepository _homeRepository = HomeRepository();
  final CategoryRepository _categoryRepository = CategoryRepository();
  List<String> _myCategoryData = [];
  List<NewsArticle> _news = [];
  List<NewsCategory> _sortedCategories = [];

  @override
  void initState() {
    super.initState();
    _fetchNewsData(); // 초기화 시 API 호출
  }

  Future<void> _fetchNewsData() async {
    try {
      final data = await _homeRepository.getUserCategory();
      final newsData = await _categoryRepository.getNewsByCategory(data[0]);

      setState(() {
        _myCategoryData = data;
        _news = newsData;
        _sortedCategories = getSortedCategories();
      });
    } catch (e) {
      // logger.e('뉴스 데이터 가져오기 실패: $e');
    }
  }

  void _onCategoryButtonClick(int index, List<NewsCategory> sortedCategories) async {
    setState(() {
      _selectedCategoryIndex = index;
    });

    await _refetchNewsData();
  }

  Future<void> _refetchNewsData() async {
    try {
      final newsData = await _categoryRepository.getNewsByCategory(
          _sortedCategories[_selectedCategoryIndex].name // 선택한 카테고리의 이름으로 데이터 요청
      );

      setState(() {
        _news = newsData;
      });
    } catch (e) {
      // logger.e('뉴스 데이터 가져오기 실패: $e');
    }
  }

  List<NewsCategory> getSortedCategories() {
    // 사용자 카테고리를 먼저 배치한 리스트 생성
    List<NewsCategory> sortedCategories = [];

    // 사용자 카테고리 추가
    for (String categoryLabel in _myCategoryData) {
      final category = NewsCategory.values.firstWhere(
            (c) => c.name == categoryLabel
      );
      if (category != null) {
        sortedCategories.add(category);
      }
    }

    // 나머지 카테고리 추가 (사용자가 선택한 카테고리를 제외하고)
    sortedCategories.addAll(NewsCategory.values.where((c) => !_myCategoryData.contains(c.name)));

    return sortedCategories;
  }

  void _onSummaryButtonClick() {
    setState(() {
      _isSummary = !_isSummary;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<NewsCategory> sortedCategories = getSortedCategories();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: beige
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultGapM * 2, vertical: defaultGapL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(sortedCategories.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 13), // 버튼 사이의 간격
                          child: CategorySelectButton(
                            label: sortedCategories[index].domain,
                            onPressed: () => _onCategoryButtonClick(index, sortedCategories),
                            isSelected: _selectedCategoryIndex == index, // 선택된 버튼 스타일링
                          ),
                        );
                      }),
                    ),
                  ),
                  const Gap(defaultGapL),
                  Text('Tip!  중요한 기사는 기사 우측 하단 스크랩 기능을 이용해보세요 !', style: CustomTextStyle.caption1.apply(color: gray).copyWith(
                    letterSpacing: -1, // 원하는 letterSpacing 값으로 조정
                  )),
                  const Gap(defaultGapS / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: _onSummaryButtonClick,
                        child: Text(
                          _isSummary ? '요약X' : '요약O',
                          style: CustomTextStyle.caption2.apply(color: _isSummary ? darkGray : Colors.white), // 색상 변경
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: _isSummary ? semiGray : primary, // 배경색 조정
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2), // padding 조정
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4), // 라운드 모서리
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Gap(defaultGapS * 2),

                  Expanded(
                    child: ListView.builder(
                      itemCount: _news.length,
                      itemBuilder: (context, index) {
                        final newsId = _news[index].id;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => NewsDetailScreen(
                                  newsId: newsId,
                                ),
                              ),
                            );
                          },
                          child: NewsCard(
                            data: _news[index],
                          ),
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