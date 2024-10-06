import 'package:flutter/material.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'components/login_buttons_by_platform.dart';
import 'components/signing_agreement_notice.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: const Alignment(0, -0.2),
                colors: [
                  Colors.white.withOpacity(0),
                  Colors.white.withOpacity(0.9),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultGapL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '플러터 놀이터',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '테스트입니다.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 150),
                    SigningAgreementNotice(
                      hasAgreed: _agreed,
                      onTappedAgreementButton: () => _onTappedAgreementButton(),
                    ),
                    SizedBox(height: defaultGapL),
                    LoginButtonsByPlatform(hasAgreed: _agreed),
                    SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onTappedAgreementButton() {
    setState(() {
      _agreed = !_agreed;
    });
  }
}