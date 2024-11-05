import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_font.dart';

class NewsTodayScreen extends StatefulWidget {
  const NewsTodayScreen({super.key});

  @override
  State<NewsTodayScreen> createState() => _NewsTodayScreen();
}

class _NewsTodayScreen extends State<NewsTodayScreen> {
  final List<Map<String, String>> news = [
    {'label': "해병대 방첩부대장, 'VIP 격노설' 부인…공수처 녹취는?", 'url': 'assets/images/news_today/news-example.png'},
    {'label': "산부인과 시술 받다 심정지 온 20대 환자…한 달여 만에 사망", 'url': 'assets/images/categories/economy.png'},
    {'label': "23명 숨진 아리셀 화재 참사, 이윤에만 혈안 안전은 뒷전 “인재였다”", 'url': 'assets/images/categories/world.png'},
    {'label': "'보상 UP' 틱톡 vs 'AI 탑재' 유튜브…뜨거운 숏폼 전선", 'url': 'assets/images/categories/tech.png'},
    {'label': "'보상 UP' 틱톡 vs 'AI 탑재' 유튜브…뜨거운 숏폼 전선", 'url': 'assets/images/categories/labor.png'},
    {'label': "'보상 UP' 틱톡 vs 'AI 탑재' 유튜브…뜨거운 숏폼 전선", 'url': 'assets/images/categories/environment.png'},
    {'label': "'보상 UP' 틱톡 vs 'AI 탑재' 유튜브…뜨거운 숏폼 전선", 'url': 'assets/images/categories/humanRights.png'},
    {'label': "'보상 UP' 틱톡 vs 'AI 탑재' 유튜브…뜨거운 숏폼 전선", 'url': 'assets/images/categories/culture.png'},
    {'label': "'보상 UP' 틱톡 vs 'AI 탑재' 유튜브…뜨거운 숏폼 전선", 'url': 'assets/images/categories/life.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: beige),
          ),
          SafeArea(
            child: SingleChildScrollView( // 스크롤 가능하도록 변경
              padding: EdgeInsets.symmetric(horizontal: defaultGapS * 2, vertical: defaultGapS * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 첫 번째와 두 번째 뉴스 항목
                  Column(
                    children: [
                      // 첫 번째 뉴스 항목
                      newsBuilder(0, 330),
                      const Gap(defaultGapS), // 간격
                      // 두 번째 뉴스 항목
                      newsBuilder(1, 133),
                      const Gap(defaultGapS), // 간격
                    ],
                  ),
                  // 이후 뉴스 항목
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 한 행에 2개
                      childAspectRatio: 1, // 버튼의 비율 조정
                    ),
                    itemCount: news.length - 2, // 첫 두 개 항목 제외
                    shrinkWrap: true, // GridView의 크기를 조정
                    physics: NeverScrollableScrollPhysics(), // GridView의 스크롤 비활성화
                    itemBuilder: (context, index) {
                      return newsBuilder(index + 2, 100);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget newsBuilder(int index, double height) {
    String imagePath = news[index]['url']!;
    String text = news[index]['label']!;

    return Container(
      height: height,
      margin: EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 딤 처리된 이미지 버튼
          GestureDetector(
            onTap: () {
              // 버튼 클릭 시의 동작
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity, // 전체 너비 사용
                  ),
                  Container(
                    color: Colors.black54, // 딤 처리
                  ),
                ],
              ),
            ),
          ),
          // 텍스트
          Container(
            padding: EdgeInsets.all(defaultGapS * 2),
            child: Text(
              text,
              style: CustomTextStyle.title3.apply(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
