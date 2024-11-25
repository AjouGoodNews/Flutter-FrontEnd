import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodnews/view/category_select/components/image_button.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_font.dart';
import 'package:goodnews/view/user_info_write/user_info_write_screen.dart';
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
    {'label': '경제', 'url': 'assets/images/categories/economy.png'},
    {'label': '세계', 'url': 'assets/images/categories/world.png'},
    {'label': '테크', 'url': 'assets/images/categories/tech.png'},
    {'label': '노동', 'url': 'assets/images/categories/labor.png'},
    {'label': '환경', 'url': 'assets/images/categories/environment.png'},
    {'label': '인권', 'url': 'assets/images/categories/humanRights.png'},
    {'label': '문화', 'url': 'assets/images/categories/culture.png'},
    {'label': '라이프', 'url': 'assets/images/categories/life.png'},
  ];

  List<String> _selectedCategories = [];

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
                             GestureDetector(
                               onTap: () {
                                 Navigator.pop(context);
                               },
                               child: Image.asset(
                                 'assets/images/icons/chevron-left-black.png',
                                 height: 24,
                                 width: 24,
                               ),
                             ),
                             Text('건너뛰기', style: CustomTextStyle.body1.apply(color: darkGray)),
                           ],
                         ),
                       ),
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
                            _onCategorySelected(imageButtons[index]['label']!);
                          },
                            isSelected: _selectedCategories.contains(imageButtons[index]['label'])
                        );
                      },
                    ),),

                    CustomButton(
                      label: '다음으로',
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => UserInfoWriteScreen(selectedCategories: _selectedCategories),
                          ),
                        );
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

  void _onCategorySelected(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        // 이미 선택된 카테고리라면 해제
        _selectedCategories.remove(category);
      } else {
        // 최대 4개 선택 가능
        if (_selectedCategories.length < 4) {
          _selectedCategories.add(category);
        } else {
          // 4개 이상 선택 시 경고 메시지 (예: SnackBar)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('최대 4개 카테고리만 선택할 수 있습니다.'),
            ),
          );
        }
      }
    });
  }
}
