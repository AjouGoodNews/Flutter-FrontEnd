import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goodnews/enums/sign_in_method.dart';
import 'package:goodnews/themes/custom_widget/interaction/custom_circular_progress_indicator.dart';
import 'package:goodnews/view/category_select/category_select_screen.dart';
import 'package:goodnews/view/login/components/apple_login_button.dart';
import 'package:goodnews/view/login/components/google_login_button.dart';
import 'package:goodnews/service/auth/authentication_service.dart';

import 'package:flutter/material.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_font.dart';
import 'package:goodnews/view_model/auth/auth_provider.dart';
import 'package:goodnews/view_model/auth/components/auth_state.dart';
import 'package:goodnews/view_model/auth/components/auth_state_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../service/logger/logger.dart';

/// on android platform, it shows only google signin
class LoginButtonsByPlatform extends ConsumerWidget {
  LoginButtonsByPlatform({
    required this.hasAgreed,
    super.key,
  });

  final bool hasAgreed;

  final AuthenticationService _authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var platform = Theme.of(context).platform;

    final authState = ref.watch(authStateProvider);

    return Column(
      children: [
        GestureDetector(
          onTap: authState == AuthState.loading
              ? null
              : () => _onTappedGoogleLogin(context, ref),
          child: (authState == AuthState.loading)
              ? const CustomCircularProgressIndicator()
              : const GoogleLoginButton(),
        ),
        const SizedBox(height: defaultGapS),
        // Visibility(
        //   visible: platform == TargetPlatform.iOS,
        //   child: GestureDetector(
        //     onTap: authState == AuthState.loading
        //         ? null
        //         : () => _onTappedAppleLogin(context, ref),
        //     child: (authState == AuthState.loading)
        //         ? const CustomCircularProgressIndicator()
        //         : const AppleLoginButton(),
        //   ),
        // ),
      ],
    );
  }

  void _onTappedGoogleLogin(BuildContext context, WidgetRef ref) async {
    // if (hasAgreed) {
    //   _handleSigningIn(context, ref, signInMethod: SignInMethod.GOOGLE);
    // } else {
    //   _showAgreementNeeded(context: context);
    //   return;
    // }
    if (hasAgreed) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const WebViewExample(signInMethod: SignInMethod.GOOGLE),
        ),
      );
    } else {
      _showAgreementNeeded(context: context);
    }
  }

  void _onTappedAppleLogin(BuildContext context, WidgetRef ref) async {
    if (hasAgreed) {
      _handleSigningIn(context, ref, signInMethod: SignInMethod.APPLE);
    } else {
      _showAgreementNeeded(context: context);
    }
  }

  void _handleSigningIn(BuildContext context, WidgetRef ref, {SignInMethod? signInMethod}) async {
    final authNotifier = ref.read(authProvider.notifier);

    await authNotifier.signIn(signInMethod);

    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => new CategorySelectScreen(),
      ),
    );
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
          content: Text('원활한 서비스 이용을 위해서는 서비스 이용약관과 개인정보 처리방침에 대한 동의가 필요합니다.',
              style: CustomTextStyle.body2),
          actions: <Widget>[
            ElevatedButton(
              child: Text('확인',
                  style: CustomTextStyle.caption1.apply(color: Colors.black87)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}

class WebViewExample extends StatelessWidget {
  final SignInMethod signInMethod;

  const WebViewExample({required this.signInMethod, super.key});

  @override
  Widget build(BuildContext context) {
    late final String url;

    // 로그인 방식에 따라 URL 설정
    if (signInMethod == SignInMethod.GOOGLE) {
      url = 'http://10.0.2.2:8080/login';  // 구글 로그인 URL로 변경
      // url = "https://accounts.google.com/o/oauth2/v2/auth?response_type=code&client_id=787484589868-258tsbj3vogqecahmeblu1q7eqtglnvr.apps.googleusercontent.com&redirect_uri=http://localhost:8080/login/oauth2/code/google";
    }

    // WebViewController 생성
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            // 페이지가 로드 완료된 후의 처리
            if (url.contains('redirect-url')) {
              Navigator.pop(context); // 웹뷰 닫기
              // 추가적인 로그인 성공 처리 로직
            }
          },
        ),
      );

    // 요청 URL 로드
    controller.loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
