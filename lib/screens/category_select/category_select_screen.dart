import 'package:flutter/material.dart';
import 'package:goodnews/screens/category_select/components/image_button.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_font.dart';
import 'package:goodnews/widgets/custom_button.dart';
import 'package:gap/gap.dart';

class CategorySelectScreen extends StatefulWidget {
  const CategorySelectScreen({super.key});

  @override
  State<CategorySelectScreen> createState() => _CategorySelectScreen();
}

class _CategorySelectScreen extends State<CategorySelectScreen> {
  final List<Map<String, String>> imageButtons = [
    {'label': '정치', 'url': 'assets/images/categories/politics.png'},
    {'label': '경제', 'url': 'assets/images/categories/politics.png'},
    {'label': '세계', 'url': 'assets/images/categories/politics.png'},
    {'label': '테크', 'url': 'assets/images/categories/politics.png'},
    {'label': '노동', 'url': 'assets/images/categories/politics.png'},
    {'label': '환경', 'url': 'assets/images/categories/politics.png'},
    {'label': '인권', 'url': 'assets/images/categories/politics.png'},
    {'label': '문화', 'url': 'assets/images/categories/politics.png'},
    {'label': '라이프', 'url': 'assets/images/categories/politics.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //       color: primary
          //   ),
          // ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultGapL, vertical: defaultGapL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                     children: [
                       Padding(
                         padding: EdgeInsets.symmetric(horizontal: defaultGapM / 2, vertical: defaultGapM),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Image.asset(
                               'assets/images/icons/chevron-left-black.png',
                               height: 24,
                               width: 24,
                             ),
                             Text('건너뛰기', style: CustomTextStyle.body1.apply(color: darkGray),)
                           ]),),
                       const Gap(defaultGapL),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Container(width: 150, height: 6, decoration: BoxDecoration(color: primary),),
                           Container(width: 150, height: 6, decoration: BoxDecoration(color: lightGray),),
                         ],
                       ),
                     ],
                    ),

                    const Gap(defaultGapL),

                    Padding(padding: EdgeInsets.symmetric(horizontal: defaultGapM / 2, vertical: defaultGapM),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('1/2', style: CustomTextStyle.caption1.apply(color: gray)),
                          const Gap(defaultGapS),
                          Text('관심 카테고리를 선택해주세요.', style: CustomTextStyle.title1),
                          const Gap(defaultGapS),
                          Text('뉴스 추천에 활용돼요. (4개까지 선택 가능)', style: CustomTextStyle.caption1.apply(color: gray)),
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
                            print('${imageButtons[index]['label']} 클릭됨'); // 클릭 시 레이블 출력
                          },
                        );
                      },
                    ),),

                    CustomButton(
                      label: '다음으로',
                      onPressed: () {
                        print('버튼이 클릭되었습니다!');
                      },
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