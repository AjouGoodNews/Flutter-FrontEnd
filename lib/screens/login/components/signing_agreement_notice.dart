import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:goodnews/themes/custom_font.dart';
import 'package:goodnews/utils/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class SigningAgreementNotice extends StatefulWidget {
  const SigningAgreementNotice({
    required this.onTappedAgreementButton,
    required this.hasAgreed,
    super.key,
  });

  final Function onTappedAgreementButton;
  final bool hasAgreed;

  @override
  State<SigningAgreementNotice> createState() => _SigningAgreementNoticeState();
}

class _SigningAgreementNoticeState extends State<SigningAgreementNotice> {
  bool _hasAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: '이용약관',
                recognizer: TapGestureRecognizer()..onTap = () => _launchInBrowser('https://google.com'),
                style: CustomTextStyle.caption1.apply(
                  decoration: TextDecoration.underline,
                ),
              ),
              TextSpan(
                text: ' 및 ',
                style: CustomTextStyle.caption1,
              ),
              TextSpan(
                text: '개인정보 처리 방침 ',
                recognizer: TapGestureRecognizer()..onTap = () => _launchInBrowser('https://google.com'),
                style: CustomTextStyle.caption1.apply(
                  decoration: TextDecoration.underline,
                ),
              ),
              TextSpan(
                text: '에 동의합니다.',
                style: CustomTextStyle.caption1,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => _onTappedAgreementButtonWrapper(),
          icon: _hasAgreed
              ? const Icon(
            Icons.check_box,
            color: Colors.black87,
            size: 24,
          )
              : const Icon(
            Icons.check_box_outline_blank,
            color: Colors.grey,
            size: 24,
          ),
        ),
      ],
    );
  }

  void _onTappedAgreementButtonWrapper() {
    setState(() {
      _hasAgreed = !_hasAgreed;
      widget.onTappedAgreementButton();
    });
  }

  Future<void> _launchInBrowser(String url) async {
    Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      logger.e('[Launching in Browser] Failed');

      throw 'Could not launch $uri';
    }
  }
}