import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:goodnews/screens/news_category/components/tag.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_font.dart';

class NewsCard extends StatefulWidget {
  final Map<String, dynamic> data;

  const NewsCard({super.key, required this.data});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool _isSummaryVisible = false;

  void _toggleSummary() {
    setState(() {
      _isSummaryVisible = !_isSummaryVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.data['date'], style: CustomTextStyle.caption1.apply(color: gray)),
                Text('본문보기', style: CustomTextStyle.caption1.apply(color: gray, decoration: TextDecoration.underline, decorationColor: gray)),
              ],
            ),
            const Gap(defaultGapS / 2),
            Text(widget.data['title'], style: CustomTextStyle.body1),
            const Gap(defaultGapS),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(widget.data['tags'].length, (tagIndex) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Tag(
                      label: widget.data['tags'][tagIndex],
                    ),
                  );
                }),
              ),
            ),
            const Gap(defaultGapS),
            if (_isSummaryVisible) ...[
              const Gap(defaultGapS),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(widget.data['points'].length, (pointIndex) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 이미지 추가
                      Image.asset(
                        'assets/images/news_category/custom-check.png',
                        width: 14, // 이미지 크기 조정
                        height: 14,
                      ),
                      const Gap(6), // 이미지와 텍스트 사이의 간격
                      Expanded(
                        child: Text(widget.data['points'][pointIndex], style: CustomTextStyle.body3,),
                      ),
                    ],
                  );
                }),
              ),
            ],
            Center(
              child: TextButton(
                onPressed: _toggleSummary,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _isSummaryVisible ? '요약접기' : '요약보기',
                      style: CustomTextStyle.caption2,
                    ),
                    const Gap(4.5), // 텍스트와 아이콘 사이의 간격
                    Icon(
                      _isSummaryVisible ? Icons.expand_less : Icons.expand_more, // 아이콘 변경
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}