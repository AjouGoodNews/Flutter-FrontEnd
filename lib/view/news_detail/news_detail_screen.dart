import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goodnews/service/logger/logger.dart';
import 'package:goodnews/view/news_category/components/category_select_button.dart';
import 'package:goodnews/view/news_category/components/news_card.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_font.dart';

class NewsDetailScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const NewsDetailScreen({super.key, required this.data});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreen();
}

class _NewsDetailScreen extends State<NewsDetailScreen> {
  bool _isThreePointOpen = false;

  void _toggleThreePoint() {
    setState(() {
      _isThreePointOpen = !_isThreePointOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        '3분뉴스',
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
                          widget.data['label'],
                          style: CustomTextStyle.caption1.apply(color: yellow),
                        ),
                      ),
                    ],
                  ),
                  const Gap(defaultGapL),
                  Text(
                    widget.data['title'],
                    style: CustomTextStyle.title3.copyWith(letterSpacing: -1),
                  ),
                  const Gap(defaultGapS / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.data['date'], style: CustomTextStyle.caption1.apply(color: darkGray)),
                      const Text(" · ", style: TextStyle(color: darkGray)),
                      Text("조선일보 / 이기자 기자", style: CustomTextStyle.caption1.apply(color: darkGray)),
                    ],
                  ),
                  const Gap(defaultGapL * 2),
                  Container(
                    padding: EdgeInsets.all(15.0), // 내부 여백
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0), // 라운드 처리
                      border: Border.all(color: primary, width: 1.0), // 테두리 색상 및 두께
                    ),
                    child: Text(
                      widget.data['summary'],
                      style: CustomTextStyle.body2.apply(color: primary),
                    ),
                  ),
                  const Gap(defaultGapS * 2),
                  Text(
                    widget.data['body'],
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
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/news_detail/triangle.png', // 로컬 이미지 경로 사용
                      ),
                      const Gap(defaultGapS),
                      GestureDetector(
                        onTap: _toggleThreePoint, // 탭 시 설명글 표시/숨김
                        child: Text(
                          '하이퍼클로바X (HyperCLOVA X)',
                          style: CustomTextStyle.body4.apply(
                            color: darkGray,
                            decoration: TextDecoration.underline, // 언더라인 추가
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (_isThreePointOpen) ...[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      margin: const EdgeInsets.only(top: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: primary, width: 1.0),
                      ),
                      child: Text(
                        '네이버가 개발한 대규모 언어 모델(LLM)로, 생성형 AI 기술을 활용해 다양한 분야에 적용될 예정이다.',
                        style: CustomTextStyle.body2,
                      ),
                    ),
                  ],
                  const Gap(defaultGapS),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/news_detail/triangle.png', // 로컬 이미지 경로 사용
                      ),
                      const Gap(defaultGapS),
                      Text(
                        '생성형 AI (Generative AI)',
                        style: CustomTextStyle.body4.apply(
                          color: darkGray,
                          decoration: TextDecoration.underline, // 언더라인 추가
                        ),
                      ),
                    ],
                  ),
                  const Gap(defaultGapS),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/news_detail/triangle.png', // 로컬 이미지 경로 사용
                      ),
                      const Gap(defaultGapS),
                      Text(
                        '록인 효과 (Lock-in Effect)',
                        style: CustomTextStyle.body4.apply(
                          color: darkGray,
                          decoration: TextDecoration.underline, // 언더라인 추가
                        ),
                      ),
                    ],
                  ),

                  const Gap(defaultGapL * 2),
                  // Image.asset(
                  //   'assets/images/news_detail/related_news.png', // 로컬 이미지 경로 사용
                  //   width: 180,
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}