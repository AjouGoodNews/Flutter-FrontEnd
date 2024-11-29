import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodnews/view/category_select/components/image_button.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_font.dart';
import 'package:goodnews/view/user_info_write/user_info_write_screen.dart';
import 'package:goodnews/widgets/custom_button.dart';
import 'package:gap/gap.dart';

import '../../enums/news_category.dart';

class CategorySelectScreen extends StatefulWidget {
  const CategorySelectScreen({super.key});

  @override
  State<CategorySelectScreen> createState() => _CategorySelectScreen();
}

class _CategorySelectScreen extends State<CategorySelectScreen> {
  final List<Map<String, String>> imageButtons = [
    {'label': NewsCategory.POLITICS.domain, 'category': NewsCategory.POLITICS.name, 'url': 'assets/images/categories/politics.png'},
    {'label': NewsCategory.ECONOMY.domain, 'category': NewsCategory.ECONOMY.name, 'url': 'assets/images/categories/economy.png'},
    {'label': NewsCategory.WORLD.domain, 'category': NewsCategory.WORLD.name, 'url': 'assets/images/categories/world.png'},
    {'label': NewsCategory.TECH.domain, 'category': NewsCategory.TECH.name, 'url': 'assets/images/categories/tech.png'},
    {'label': NewsCategory.LABOR.domain, 'category': NewsCategory.LABOR.name, 'url': 'assets/images/categories/labor.png'},
    {'label': NewsCategory.ENVIRONMENT.domain, 'category': NewsCategory.ENVIRONMENT.name, 'url': 'assets/images/categories/environment.png'},
    {'label': NewsCategory.HUMAN_RIGHTS.domain, 'category': NewsCategory.HUMAN_RIGHTS.name, 'url': 'assets/images/categories/humanRights.png'},
    {'label': NewsCategory.CULTURE.domain, 'category': NewsCategory.CULTURE.name, 'url': 'assets/images/categories/culture.png'},
    {'label': NewsCategory.LIFE.domain, 'category': NewsCategory.LIFE.name, 'url': 'assets/images/categories/life.png'},
  ];

  List<NewsCategory> _selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultGapM / 2, vertical: defaultGapM),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('1/2', style: CustomTextStyle.caption1.apply(color: gray)),
                          const Gap(defaultGapS),
                          Text('관심 카테고리를 선택해주세요.', style: CustomTextStyle.title1),
                          const Gap(defaultGapS),
                          Text('뉴스 추천에 활용돼요. (4개까지 선택 가능)', style: CustomTextStyle.caption1.apply(color: gray)),
                        ],
                      ),
                    ),
                    const Gap(defaultGapXL),
                    Expanded(
                      child: GridView.builder(
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
                              _onCategorySelected(imageButtons[index]['category']!);
                            },
                            isSelected: _selectedCategories.contains(NewsCategory.values.firstWhere((category) => category.name == imageButtons[index]['category'])),
                          );
                        },
                      ),
                    ),
                    CustomButton(
                      label: '다음으로',
                      onPressed: () {
                        List<String> selectedCategoryNames = NewsCategory.getCategoryNames(_selectedCategories);
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => UserInfoWriteScreen(selectedCategories: selectedCategoryNames),
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

  void _onCategorySelected(String categoryName) {
    setState(() {
      NewsCategory selectedCategory = NewsCategory.values.firstWhere((category) => category.name == categoryName);
      if (_selectedCategories.contains(selectedCategory)) {
        // 이미 선택된 카테고리라면 해제
        _selectedCategories.remove(selectedCategory);
      } else {
        // 최대 4개 선택 가능
        if (_selectedCategories.length < 4) {
          _selectedCategories.add(selectedCategory);
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