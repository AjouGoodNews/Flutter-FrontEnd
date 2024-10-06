import 'package:goodnews/enums/sign_in_method.dart';
import 'package:goodnews/screens/login/components/google_login_button.dart';
import 'package:goodnews/services/authentication_service.dart';

import 'package:flutter/material.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_font.dart';

/// on android platform, it shows only google signin
class LoginButtonsByPlatform extends StatelessWidget {
  LoginButtonsByPlatform({
    required this.hasAgreed,
    super.key,
  });

  final bool hasAgreed;

  final AuthenticationService _authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    var platform = Theme.of(context).platform;

    return Column(
      children: [
        GestureDetector(
          onTap: () => _onTappedGoogleLogin(context),
          child: const GoogleLoginButton(),
        ),
        const SizedBox(height: defaultGapS),
      ],
    );
  }

  void _onTappedGoogleLogin(BuildContext context) async {
    if (hasAgreed) {
      _handleSigningIn(context, signInMethod: SignInMethod.GOOGLE);
    } else {
      _showAgreementNeeded(context: context);
      return;
    }
  }

  void _handleSigningIn(BuildContext context, {SignInMethod? signInMethod}) async {
    await _authenticationService.signIn(signInMethod: signInMethod);
  }

  void _showAgreementNeeded({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '로그인 실패',
            style: CustomTextStyle.header1,
          ),
          content: Text('원활한 서비스 이용을 위해서는 서비스 이용약관과 개인정보 처리방침에 대한 동의가 필요합니다.', style: CustomTextStyle.body2),
          actions: <Widget>[
            ElevatedButton(
              child: Text('확인', style: CustomTextStyle.caption1.apply(color: Colors.black87)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}