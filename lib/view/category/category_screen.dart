import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodnews/view/category/category_detail_screen.dart';
import 'package:goodnews/view/category_select/components/image_button.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_font.dart';
import 'package:gap/gap.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreen();
}

class _CategoryScreen extends State<CategoryScreen> {
  final List<Map<String, String>> imageButtons = [
    {'label': '정치', 'url': 'assets/images/categories/politics.png', 'category': 'POLITICS'},
    {'label': '경제', 'url': 'assets/images/categories/economy.png', 'category': 'ECONOMY'},
    {'label': '세계', 'url': 'assets/images/categories/world.png', 'category': 'WORLD'},
    {'label': '테크', 'url': 'assets/images/categories/tech.png', 'category': 'TECH'},
    {'label': '노동', 'url': 'assets/images/categories/labor.png', 'category': 'LABOR'},
    {'label': '환경', 'url': 'assets/images/categories/environment.png', 'category': 'ENVIRONMENT'},
    {'label': '인권', 'url': 'assets/images/categories/humanRights.png', 'category': 'HUMAN_RIGHTS'},
    {'label': '문화', 'url': 'assets/images/categories/culture.png', 'category': 'CULTURE'},
    {'label': '라이프', 'url': 'assets/images/categories/life.png', 'category': 'LIFE'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('카테고리', style: CustomTextStyle.body1), // AppBar 제목 설정
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
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultGapL, vertical: defaultGapL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(padding: EdgeInsets.symmetric(horizontal: defaultGapM / 2, vertical: defaultGapL),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('오늘은 어떤 산업의 기사를 읽어볼까요?', style: CustomTextStyle.title2),
                          const Gap(defaultGapS),
                          Text("원희님은 주로 '정치' 관련 기사를 읽어요.", style: CustomTextStyle.caption1.apply(color: darkGray)),
                        ],),),

                    const Gap(defaultGapXL),

                    Expanded(child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 3개 열
                        crossAxisSpacing: defaultGapL, // 열 사이 간격
                        mainAxisSpacing: defaultGapM, // 행 사이 간격
                      ),
                      itemCount: imageButtons.length, // 버튼 수
                      itemBuilder: (context, index) {
                        return ImageButton(
                          imageUrl: imageButtons[index]['url']!, // URL
                          label: imageButtons[index]['label']!, // 레이블
                          onPressed: () {
                            final label = imageButtons[index]['label'];
                            final category = imageButtons[index]['category'];

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
                        );},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}