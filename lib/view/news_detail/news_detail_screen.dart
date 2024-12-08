import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goodnews/model/news/news_article_detail.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_font.dart';

import '../../repository/category/category_repository.dart';

class NewsDetailScreen extends StatefulWidget {
  final int newsId;
  const NewsDetailScreen({super.key, required this.newsId});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreen();
}

class _NewsDetailScreen extends State<NewsDetailScreen> {
  bool _isThreePointOpen1 = false;
  bool _isThreePointOpen2 = false;
  bool _isThreePointOpen3 = false;
  final CategoryRepository _categoryRepository = CategoryRepository();
  NewsArticleDetail? _news;

  @override
  void initState() {
    super.initState();
    _fetchNewsData();
  }

  Future<void> _fetchNewsData() async {
    try {
      final newsData = await _categoryRepository.getNewsDetailByNewsId(widget.newsId);

      setState(() {
        _news = newsData;
      });
    } catch (e) {
      // logger.e('뉴스 데이터 가져오기 실패: $e');
    }
  }

  void _toggleThreePoint(int index) {
    setState(() {
      if (index == 1) {
        _isThreePointOpen1 = !_isThreePointOpen1;
      } else if (index == 2) {
        _isThreePointOpen2 = !_isThreePointOpen2;
      } else if (index == 3) {
        _isThreePointOpen3 = !_isThreePointOpen3;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_news == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('뉴스 본문', style: CustomTextStyle.body1),
          backgroundColor: primary,
        ),
        body: Center(child: CircularProgressIndicator()), // 로딩 중 표시
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('뉴스 본문', style: CustomTextStyle.body1), // AppBar 제목 설정
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
            child: SingleChildScrollView( // SingleChildScrollView로 감싸기
              padding: EdgeInsets.symmetric(horizontal: defaultGapM * 2, vertical: defaultGapL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        _news?.publisher ?? '3분뉴스',
                        style: CustomTextStyle.caption2.apply(color: gray),
                      ),
                      const Gap(defaultGapM),
                      Container(
                        padding: EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(5.0), // 라운드 처리
                          border: Border.all(color: primary, width: 1.0), // 테두리 색상 및 두께
                        ),
                        child: Text(
                          // widget.data['label'],
                          '테크',
                          style: CustomTextStyle.caption1.apply(color: yellow),
                        ),
                      ),
                    ],
                  ),
                  const Gap(defaultGapL),
                  Text(
                    _news!.title,
                    style: CustomTextStyle.title3.copyWith(letterSpacing: -1),
                  ),
                  const Gap(defaultGapS / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          _news!.publishedDate.toIso8601String().split('T')[0],
                          style: CustomTextStyle.caption1.apply(color: darkGray)
                      ),
                      const Text(" · ", style: TextStyle(color: darkGray)),
                      Text("조선일보 / 이기자 기자", style: CustomTextStyle.caption1.apply(color: darkGray)),
                    ],
                  ),
                  const Gap(defaultGapL * 2),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(15.0), // 내부 여백
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0), // 라운드 처리
                      border: Border.all(color: primary, width: 1.0), // 테두리 색상 및 두께
                    ),
                    child: Text(
                      _news!.shortcut,
                      style: CustomTextStyle.body2.apply(color: primary),
                    ),
                  ),
                  const Gap(defaultGapS * 2),
                  Text(
                    _news!.content,
                    style: CustomTextStyle.body2,
                  ),
                  const Gap(defaultGapL * 2),

                  Image.asset(
                    'assets/images/news_detail/three_point.png', // 로컬 이미지 경로 사용
                    width: 75,
                  ),
                  const Gap(defaultGapS),
                  Text(
                    '알아두시면 좋을 만한 세가지 포인트 단어를 알려드려요. 단어를 눌러보세요!',
                    style: CustomTextStyle.caption2.apply(color: gray),
                  ),
                  const Gap(defaultGapM),

                  _buildKeywordRow(1, _news!.keyword1, _news!.keywordDetail1, _isThreePointOpen1),
                  const Gap(defaultGapS * 2),
                  _buildKeywordRow(2, _news!.keyword2, _news!.keywordDetail2, _isThreePointOpen2),
                  const Gap(defaultGapS * 2),
                  _buildKeywordRow(3, _news!.keyword3, _news!.keywordDetail3, _isThreePointOpen3),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildKeywordRow(int index, String keyword, String keywordDetail, bool isOpen) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/news_detail/triangle.png', // 로컬 이미지 경로 사용
            ),
            const Gap(defaultGapS),
            GestureDetector(
              onTap: () => _toggleThreePoint(index), // 키워드 클릭 시 상태 토글
              child: Text(
                keyword,
                style: CustomTextStyle.body2.apply(
                  color: darkGray,
                  decoration: TextDecoration.underline, // 언더라인 추가
                ),
              ),
            ),
          ],
        ),
        if (isOpen) ...[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: primary, width: 1.0),
            ),
            child: Text(
              keywordDetail,
              style: CustomTextStyle.body2,
            ),
          ),
        ],
      ],
    );
  }
}