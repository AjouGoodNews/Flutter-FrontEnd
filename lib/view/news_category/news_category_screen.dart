import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goodnews/repository/home/home_repository.dart';
import 'package:goodnews/service/logger/logger.dart';
import 'package:goodnews/view/news_category/components/category_select_button.dart';
import 'package:goodnews/view/news_category/components/news_card.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_font.dart';
import 'package:goodnews/view/news_detail/news_detail_screen.dart';

import '../../enums/news_category.dart';

class NewsCategoryScreen extends StatefulWidget {
  const NewsCategoryScreen({super.key});

  @override
  State<NewsCategoryScreen> createState() => _NewsCategoryScreen();
}

class _NewsCategoryScreen extends State<NewsCategoryScreen> {
  int _selectedCategoryIndex = 0;
  bool _isSummary = true;
  final HomeRepository _repository = HomeRepository(); // Repository 인스턴스 생성
  List<String> _myCategoryData = []; // API 호출 결과를 저장할 리스트

  @override
  void initState() {
    super.initState();
    _fetchNewsData(); // 초기화 시 API 호출
  }

  Future<void> _fetchNewsData() async {
    try {
      // API 호출
      final data = await _repository.getUserCategory();
      setState(() {
        _myCategoryData = data; // API로부터 받은 데이터를 상태에 저장
      });
    } catch (e) {
      // logger.e('뉴스 데이터 가져오기 실패: $e');
    }
  }

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

  // final List<Map<String, dynamic>> categories = [
  //   {'label': '정치', 'idx': 0},
  //   {'label': '경제', 'idx': 1},
  //   {'label': '세계', 'idx': 2},
  //   {'label': '테크', 'idx': 3},
  //   {'label': '노동', 'idx': 4},
  //   {'label': '환경', 'idx': 5},
  //   {'label': '인권', 'idx': 6},
  //   {'label': '문화', 'idx': 7},
  //   {'label': '라이프', 'idx': 8},
  // ];

  // final List<Map<String, dynamic>> categories = [
  //   {'label': '경제', 'idx': 0},
  //   {'label': '세계', 'idx': 1},
  //   {'label': '테크', 'idx': 2},
  //   {'label': '정치', 'idx': 3},
  //   {'label': '노동', 'idx': 4},
  //   {'label': '환경', 'idx': 5},
  //   {'label': '문화', 'idx': 6},
  //   {'label': '인권', 'idx': 7},
  //   {'label': '라이프', 'idx': 8},
  // ];

  final List<Map<String, dynamic>> cardData = [
    {
      'date': '2024.10.10',
      'title': '두 독립 기업으로 쪼개지는 BMC··· ‘의도는?’',
      'tags': ['비즈니스', '엔터프라이즈 애플리케이션'],
      'points': ['BMC가 두 개의 독립 회사로 분할하기로 결정', '결국 매각을 위한 행보일 수 있음', '종전의 BMC 이름을 유지하는 한편, 다른 조직은 BMC 헬릭스가 될 것이라고 발표'],
      'summary': '한 가트너 애널리스트는 최종 계획이 각각 다른 구매자에게 매각하려는 것일 가능성을 제시했다.',
      'body': 'BMC가 두 개의 독립 회사로 분할하기로 한 결정은 시기적인 측면에서는 놀랍지만, 결국 매각을 위한 행보일 수 있다고 가트너의 부사장 애널리스트 그레그 지그프리드가 지난 9일 분석했다. BMC는 향후 두 개의 기업으로 분할되며, 이 중 하나는 종전의 BMC 이름을 유지하는 한편, 다른 조직은 BMC 헬릭스가 될 것이라고 발표한 바 있다. 지그프리드의 이번 분석은 해당 발표에 대한 반응이다. 지난 9일 BMC 아이만 사이드(Ayman Sayed) 회사 CEO 겸 사장은 자사 웹사이트에 게시한 글에서 “두 회사가 각자의 시장에 더 나은 서비스를 제공할 수 있을 것으로 판단했기 때문에 분할을 결정했다. 각 비즈니스는 성장 기회, 마진 및 수익성, 경쟁 환경에서 고유한 프로필과 특성을 가지고 있다”라고 밝혔다.',
      'label': '세계',
      'category': 'WORLD'
    },
    {
      'date': '2024.10.15',
      'title': '한국 경제 성장률, 예상보다 높은 3% 기록',
      'tags': ['경제', '성장'],
      'points': [
        '2024년 3분기 경제 성장률 3%로 발표',
        '소비 증가와 수출 호조가 주요 원인',
        '전문가들은 내년에도 긍정적인 전망을 내놓고 있다.'
      ],
      'summary': '한국 경제가 예상보다 높은 성장률을 기록하며 회복세를 보이고 있다.',
      'body': '한국은행은 2024년 3분기 경제 성장률이 3%에 달했다고 발표했다. 이는 소비자 지출 증가와 수출 호조가 주요 원인으로 작용했다. 전문가들은 이러한 증가세가 지속될 것으로 보이며, 내년에도 긍정적인 성장세를 이어갈 것이라는 전망을 내놓고 있다.',
      'label': '경제',
      'category': 'ECONOMY'
    },
    {
      'date': '2024.10.09',
      'title': '리누스 토발즈 “커밋 메시지에 수동태 표현 삼가야”’',
      'tags': ['개발자', '리눅스'],
      'points': ['수동적 표현은 명확하지 않다', '가급적 능동태를 사용하도록 요청', '리눅스 6.12는 11월 하반기에 출시될 예정'],
      'summary': '리눅스 6.12의 최신 릴리스 후보가 주말에 발표된 가운데, 리눅스 창립자 라이너스 토발즈가 개발 문법에 대한 의견을 제시했다.',
      'body': '네오윈(Neowin) 보도에 따르면 그는 개발자들이 커밋 메시지에 능동적 언어가 아닌 수동적 언어를 사용하는 것에 대해 불만을 표출했다. 수동적 표현은 명확하지 않다는 이유에서다. 커밋 메시지는 개발자가 버전 관리 시스템에 변경 사항을 저장할 때 작성하는 짧은 설명이다. 토발즈는 “병합 커밋 메시지를 합리적으로 ‘일관성 있게’ 만들려고 나는 노력하곤 한다. 풀 리퀘스트 언어를 보다 표준화된 레이아웃과 언어 사용에 맞게 편집하는 이유이기도 하다. 큰 노력이 들어가는 작업이 아니다. 대부분의 경우 말 그대로 공백만 있기 때문에 15가지의 다른 들여쓰기 모델과 글머리 기호 목록 구문이 필요하지 않다”라고 설명했다. 그는 이어 “나는 보통 텍스트를 읽으면서 이 작업을 한다. 추가로 작업하지 않는다. 하지만 추가 작업이 필요할 때도 있다. 일부 개발자가 수동태를 사용하면 능동형으로 설명을 다시 쓰곤 한다. 그래서 나는 가급적 능동태를 사용하도록 요청하고자 한다”라고 말했다.',
      'label': '테크',
      'category': 'TECH'
    },
    {
      'date': '2024.09.20',
      'title': '네이버 날았다..쇼핑/웹툰 약 40%이상 폭풍성장?!',
      'tags': ['주가 상승', '쇼핑', '웹툰'],
      'points': ['역대 최대 분기 매출 기록', 'AI와 글로벌 확장으로 추가 성장 기대', '중소상공인 및 글로벌 시장 확장 주도'],
      'summary': '네이버가 사우디아라비아에 중동법인을 설립한다. 정보기술(IT) 청정구역인 산유국에서의 글로벌 비즈니스가 본격적으로 전개될 전망이다.',
      'body': '네이버는 중동법인을 설치한 후 사우디아라비아가 해외기업을 대상으로 제공하는 프로그램에 참여해 국책과제를 수행하고 다양한 비즈니스 기회를 발굴할 계획이다. 주로 인공지능(AI), 클라우드, 데이터센터 등 첨단기술시장을 공략할 것으로 알려졌다. 사우디아라비아에서 진행하고 있는 개별사업 단위별 조인트벤처(JV) 설립도 추진 중이다. 사우디아라비아 디지털 트윈 플랫폼 구축 사업의 파트너인 자치행정주택부(MOMAH) 및 국립주택공사(NHC)와 함께 JV를 구성하는 방식이다. 초대 법인장으로는 채선주 네이버 대외·ESG 정책 대표가 거론된다. 채 대표는 네이버의 아라비아 사업을 초창기부터 총괄해 왔다. 다만 국내 업무를 내려놓고 중동 업무에 주력할지 겸업하는 형태일지는 미지수다.',
      'label': '테크',
      'category': 'TECH'
    },
    {
      'date': '2024.10.16',
      'title': '유럽연합, 기후 변화 대응을 위한 새로운 법안 발의',
      'tags': ['환경', '정책'],
      'points': [
        '유럽연합, 기후 변화 대응을 위한 법안 초안 발표',
        '2030년까지 온실가스 배출량 55% 감축 목표',
        '회원국들의 적극적인 참여가 필요하다.'
      ],
      'summary': '유럽연합이 기후 변화에 대응하기 위한 새로운 법안을 발의하며, 회원국들의 협력이 중요하다고 강조했다.',
      'body': '유럽연합은 기후 변화 대응을 위해 새로운 법안을 발의했다. 이 법안은 2030년까지 온실가스 배출량을 55% 감축하는 것을 목표로 하고 있으며, 회원국들의 적극적인 참여가 필요하다고 강조했다. 전문가들은 이 법안이 기후 변화 대응에 큰 전환점이 될 것이라고 기대하고 있다.',
      'label': '세계',
      'category': 'WORLD'
    },
    {
      'date': '2024.10.17',
      'title': '한국, 플라스틱 사용 줄이기 위한 새로운 정책 발표',
      'tags': ['환경', '정책'],
      'points': [
        '2025년부터 일회용 플라스틱 사용 금지',
        '재활용 촉진을 위한 인센티브 제공',
        '시민들의 적극적인 참여 필요'
      ],
      'summary': '한국 정부가 일회용 플라스틱 사용을 줄이기 위한 정책을 발표하며, 재활용을 촉진할 방안을 마련했다.',
      'body': '한국 정부는 환경 보호를 위해 2025년부터 일회용 플라스틱 사용을 금지하는 정책을 발표했다. 이와 함께 재활용을 촉진하기 위한 인센티브를 제공하고, 시민들의 적극적인 참여를 유도할 계획이다. 전문가들은 이러한 정책이 플라스틱 오염 문제를 해결하는 데 큰 도움이 될 것이라고 기대하고 있다.',
      'label': '환경',
      'category': 'ENVIRONMENT'
    },
    {
      'date': '2024.10.18',
      'title': '자연과 함께하는 도시 농업, 새로운 트렌드로 자리잡다',
      'tags': ['라이프', '농업'],
      'points': [
        '도시 내 작은 공간에서 시작하는 농업',
        '친환경 식품 생산에 대한 관심 증가',
        '커뮤니티 활성화에도 기여'
      ],
      'summary': '도시 농업이 자연과의 조화를 이루며 새로운 라이프스타일로 떠오르고 있다.',
      'body': '도시 농업이 최근 자연과 함께하는 라이프스타일로 주목받고 있다. 많은 도시 주민들이 작은 공간에서 친환경 식품을 생산하며, 이를 통해 건강한 식습관을 유지하고 있다. 이와 함께 도시 농업은 지역 사회의 활성화에도 기여하고 있어, 앞으로 더욱 확산될 것으로 보인다.',
      'label': '라이프',
      'category': 'LIFE'
    },
    {
      'date': '2024.10.16',
      'title': '주식 시장, 외국인 투자 증가로 상승세',
      'tags': ['경제', '주식'],
      'points': [
        '외국인 투자자들이 대규모 매수에 나섰다',
        '주식 시장 지수, 2% 상승',
        '전문가들은 외국인 투자 유입이 계속될 것으로 전망'
      ],
      'summary': '국내 주식 시장이 외국인 투자자들의 적극적인 매수로 상승세를 보이고 있다.',
      'body': '최근 외국인 투자자들이 국내 주식 시장에 대규모 매수에 나서면서, 주식 시장 지수가 2% 상승했다. 전문가들은 이러한 외국인 투자 유입이 계속될 것으로 전망하며, 긍정적인 경제 지표와 함께 주식 시장의 안정성을 높일 것으로 기대하고 있다.',
      'label': '경제',
      'category': 'ECONOMY'
    },
    {
      'date': '2024.10.17',
      'title': '한국은행, 금리 동결 결정',
      'tags': ['경제', '금리'],
      'points': [
        '금리 동결로 경제 안정화 의지 표명',
        '물가 상승 압력에도 불구하고 정책 유지',
        '향후 경제 지표에 따라 금리 조정 가능성'
      ],
      'summary': '한국은행이 금리를 동결하며 경제 안정화에 힘쓰겠다는 의지를 밝혔다.',
      'body': '한국은행은 최근 금융통화위원회를 열고 기준금리를 동결하기로 결정했다. 물가 상승 압력이 지속되고 있지만, 경제 안정화를 위해 현 정책을 유지하기로 했다. 한국은행은 향후 경제 지표에 따라 금리를 조정할 수 있다고 밝혔다.',
      'label': '경제',
      'category': 'ECONOMY'
    }
  ];

  List<NewsCategory> getSortedCategories() {
    // 사용자 카테고리를 먼저 배치한 리스트 생성
    List<NewsCategory> sortedCategories = [];

    // 사용자 카테고리 추가
    for (String categoryLabel in _myCategoryData) {
      final category = NewsCategory.values.firstWhere(
            (c) => c.name == categoryLabel
      );
      if (category != null) {
        sortedCategories.add(category);
      }
    }

    // 나머지 카테고리 추가 (사용자가 선택한 카테고리를 제외하고)
    sortedCategories.addAll(NewsCategory.values.where((c) => !_myCategoryData.contains(c.name)));

    return sortedCategories;
  }

  List<Map<String, dynamic>> getFilteredCardData() {
    return cardData.where((card) {
      return card['category'] == getSortedCategories()[_selectedCategoryIndex].name;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredCardData = getFilteredCardData();
    List<NewsCategory> sortedCategories = getSortedCategories();

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
                      children: List.generate(sortedCategories.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 13), // 버튼 사이의 간격
                          child: CategorySelectButton(
                            label: sortedCategories[index].domain,
                            onPressed: () => _onCategoryButtonClick(index),
                            isSelected: _selectedCategoryIndex == index, // 선택된 버튼 스타일링
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
                      itemCount: filteredCardData.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => NewsDetailScreen(data: filteredCardData[index]),
                              ),
                            );
                          },
                          child: NewsCard(
                            data: filteredCardData[index],
                          ),
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