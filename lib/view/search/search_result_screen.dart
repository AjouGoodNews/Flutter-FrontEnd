import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goodnews/model/news/news_article.dart';
import 'package:goodnews/repository/category/category_repository.dart';
import 'package:goodnews/repository/home/home_repository.dart';
import 'package:goodnews/repository/search/search_repository.dart';
import 'package:goodnews/view/news_category/components/category_select_button.dart';
import 'package:goodnews/view/news_category/components/news_card.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_font.dart';
import 'package:goodnews/view/news_detail/news_detail_screen.dart';

import '../../enums/news_category.dart';

class SearchResultScreen extends StatefulWidget {
  final String? query;
  const SearchResultScreen({super.key, required this.query});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreen();
}

class _SearchResultScreen extends State<SearchResultScreen> {
  bool _isSummary = true;
  final SearchRepository _searchRepository = SearchRepository();
  List<NewsArticle> _news = [];

  @override
  void initState() {
    super.initState();
    _fetchNewsData(); // 초기화 시 API 호출
  }

  Future<void> _fetchNewsData() async {
    if (widget.query == null) return;

    try {
      final newsData = await _searchRepository.getNewsByQuery(widget.query!);

      setState(() {
        _news = newsData;
      });
    } catch (e) {
      // logger.e('뉴스 데이터 가져오기 실패: $e');
    }
  }

  void _onSummaryButtonClick() {
    setState(() {
      _isSummary = !_isSummary;
    });
  }

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
                color: beige
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultGapM * 2, vertical: defaultGapL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    child: _news.isEmpty
                        ? Center(
                      child: Text(
                        '뉴스 정보가 없어요',
                        style: CustomTextStyle.caption2.apply(color: gray), // 텍스트 스타일 조정
                      ),
                    )
                        : ListView.builder(
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