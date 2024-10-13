import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goodnews/screens/news_category/components/category_select_button.dart';
import 'package:goodnews/screens/news_category/components/news_card.dart';
import 'package:goodnews/screens/news_today/news_today_screen.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_font.dart';

class NewsCategoryScreen extends StatefulWidget {
  const NewsCategoryScreen({super.key});

  @override
  State<NewsCategoryScreen> createState() => _NewsCategoryScreen();
}

class _NewsCategoryScreen extends State<NewsCategoryScreen> {
  int _selectedCategoryIndex = 0;
  bool _isSummary = true;

  void _onCategoryButtonClick(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  void _onSummaryButtonClick() {
    setState(() {
      _isSummary = !_isSummary;
    });
  }

  final List<Map<String, dynamic>> categories = [
    {'label': '정치', 'idx': 0},
    {'label': '경제', 'idx': 1},
    {'label': '세계', 'idx': 2},
    {'label': '테크', 'idx': 3},
    {'label': '노동', 'idx': 4},
    {'label': '환경', 'idx': 5},
    {'label': '인권', 'idx': 6},
    {'label': '문화', 'idx': 7},
    {'label': '라이프', 'idx': 8},
  ];

  final List<Map<String, dynamic>> cardData = [
    {
      'date': '2024.10.10',
      'title': '두 독립 기업으로 쪼개지는 BMC··· ‘의도는?’',
      'tags': ['비즈니스', '엔터프라이즈 애플리케이션'],
      'points': ['BMC가 두 개의 독립 회사로 분할하기로 결정', '결국 매각을 위한 행보일 수 있음', '종전의 BMC 이름을 유지하는 한편, 다른 조직은 BMC 헬릭스가 될 것이라고 발표'],
      'summary': '한 가트너 애널리스트는 최종 계획이 각각 다른 구매자에게 매각하려는 것일 가능성을 제시했다.',
      'body': 'BMC가 두 개의 독립 회사로 분할하기로 한 결정은 시기적인 측면에서는 놀랍지만, 결국 매각을 위한 행보일 수 있다고 가트너의 부사장 애널리스트 그레그 지그프리드가 지난 9일 분석했다. BMC는 향후 두 개의 기업으로 분할되며, 이 중 하나는 종전의 BMC 이름을 유지하는 한편, 다른 조직은 BMC 헬릭스가 될 것이라고 발표한 바 있다. 지그프리드의 이번 분석은 해당 발표에 대한 반응이다. 지난 9일 BMC 아이만 사이드(Ayman Sayed) 회사 CEO 겸 사장은 자사 웹사이트에 게시한 글에서 “두 회사가 각자의 시장에 더 나은 서비스를 제공할 수 있을 것으로 판단했기 때문에 분할을 결정했다. 각 비즈니스는 성장 기회, 마진 및 수익성, 경쟁 환경에서 고유한 프로필과 특성을 가지고 있다”라고 밝혔다.',
    },
    {
      'date': '2024.10.09',
      'title': '리누스 토발즈 “커밋 메시지에 수동태 표현 삼가야”’',
      'tags': ['개발자', '리눅스'],
      'points': ['수동적 표현은 명확하지 않다', '가급적 능동태를 사용하도록 요청', '리눅스 6.12는 11월 하반기에 출시될 예정'],
      'summary': '리눅스 6.12의 최신 릴리스 후보가 주말에 발표된 가운데, 리눅스 창립자 라이너스 토발즈가 개발 문법에 대한 의견을 제시했다.',
      'body': '네오윈(Neowin) 보도에 따르면 그는 개발자들이 커밋 메시지에 능동적 언어가 아닌 수동적 언어를 사용하는 것에 대해 불만을 표출했다. 수동적 표현은 명확하지 않다는 이유에서다. 커밋 메시지는 개발자가 버전 관리 시스템에 변경 사항을 저장할 때 작성하는 짧은 설명이다. 토발즈는 “병합 커밋 메시지를 합리적으로 ‘일관성 있게’ 만들려고 나는 노력하곤 한다. 풀 리퀘스트 언어를 보다 표준화된 레이아웃과 언어 사용에 맞게 편집하는 이유이기도 하다. 큰 노력이 들어가는 작업이 아니다. 대부분의 경우 말 그대로 공백만 있기 때문에 15가지의 다른 들여쓰기 모델과 글머리 기호 목록 구문이 필요하지 않다”라고 설명했다. 그는 이어 “나는 보통 텍스트를 읽으면서 이 작업을 한다. 추가로 작업하지 않는다. 하지만 추가 작업이 필요할 때도 있다. 일부 개발자가 수동태를 사용하면 능동형으로 설명을 다시 쓰곤 한다. 그래서 나는 가급적 능동태를 사용하도록 요청하고자 한다”라고 말했다.',
    },
    {
      'date': '2024.09.20',
      'title': '네이버 날았다..쇼핑/웹툰 약 40%이상 폭풍성장?!',
      'tags': ['주가 상승', '쇼핑', '웹툰'],
      'points': ['역대 최대 분기 매출 기록', 'AI와 글로벌 확장으로 추가 성장 기대', '중소상공인 및 글로벌 시장 확장 주도'],
      'summary': '네이버가 사우디아라비아에 중동법인을 설립한다. 정보기술(IT) 청정구역인 산유국에서의 글로벌 비즈니스가 본격적으로 전개될 전망이다.',
      'body': '네이버는 중동법인을 설치한 후 사우디아라비아가 해외기업을 대상으로 제공하는 프로그램에 참여해 국책과제를 수행하고 다양한 비즈니스 기회를 발굴할 계획이다. 주로 인공지능(AI), 클라우드, 데이터센터 등 첨단기술시장을 공략할 것으로 알려졌다. 사우디아라비아에서 진행하고 있는 개별사업 단위별 조인트벤처(JV) 설립도 추진 중이다. 사우디아라비아 디지털 트윈 플랫폼 구축 사업의 파트너인 자치행정주택부(MOMAH) 및 국립주택공사(NHC)와 함께 JV를 구성하는 방식이다. 초대 법인장으로는 채선주 네이버 대외·ESG 정책 대표가 거론된다. 채 대표는 네이버의 아라비아 사업을 초창기부터 총괄해 왔다. 다만 국내 업무를 내려놓고 중동 업무에 주력할지 겸업하는 형태일지는 미지수다.',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
                      children: List.generate(categories.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 13), // 버튼 사이의 간격
                          child: CategorySelectButton(
                            label: categories[index]['label'],
                            onPressed: () => _onCategoryButtonClick(categories[index]['idx']),
                            isSelected: _selectedCategoryIndex == categories[index]['idx'], // 선택된 버튼 스타일링
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
                      itemCount: cardData.length,
                      itemBuilder: (context, index) {
                        return NewsCard(
                          data: cardData[index],
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