import 'package:flutter/material.dart';
import 'package:goodnews/view/user_info_write/components/birth_year_dropdown.dart';
import 'package:goodnews/view/user_info_write/components/gender_button.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_font.dart';
import 'package:goodnews/widgets/custom_button.dart';
import 'package:gap/gap.dart';

class UserInfoWriteScreen extends StatefulWidget {
  const UserInfoWriteScreen({super.key});

  @override
  State<UserInfoWriteScreen> createState() => _UserInfoWriteScreen();
}

class _UserInfoWriteScreen extends State<UserInfoWriteScreen> {
  String? selectedGender = '남성'; // 선택된 성별을 저장할 변수
  int? selectedYear; // 선택된 생년을 저장할 변수

  void _selectGender(String gender) {
    setState(() {
      selectedGender = gender; // 선택된 성별 업데이트
    });
  }

  void _onYearChanged(int? year) {
    setState(() {
      selectedYear = year; // 선택된 생년 업데이트
    });
  }

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
                                Container(width: 150, height: 6, decoration: BoxDecoration(color: primary),),
                              ],
                            ),
                          ],
                        ),

                        const Gap(defaultGapL),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('2/2', style: CustomTextStyle.caption1.apply(color: gray)),
                            const Gap(defaultGapS),
                            Text('추가 정보를 입력해주세요.', style: CustomTextStyle.title1),
                          ],
                        ),

                        const Gap(defaultGapXL * 2),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('성별', style: CustomTextStyle.caption1.apply(color: darkGray)),
                            const Gap(defaultGapM),
                            Row(
                              children: [
                                GenderButton(
                                  label: '남성',
                                  isSelected: selectedGender == '남성',
                                  onPressed: () => _selectGender('남성'), // 남성 버튼 클릭 시
                                ),
                                const Gap(defaultGapL / 2),
                                GenderButton(
                                  label: '여성',
                                  isSelected: selectedGender == '여성',
                                  onPressed: () => _selectGender('여성'), // 여성 버튼 클릭 시
                                ),
                              ],
                            ),
                            const Gap(defaultGapXL),
                            Text('출생년도', style: CustomTextStyle.caption1.apply(color: darkGray)),
                            const Gap(defaultGapM),
                            BirthYearDropdown(
                              selectedYear: selectedYear,
                              onChanged: _onYearChanged, // 생년 변경 시 호출될 콜백
                            ),
                          ],
                        ),
                      ],
                    ),

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