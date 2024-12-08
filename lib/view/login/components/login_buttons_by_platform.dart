import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goodnews/enums/sign_in_method.dart';
import 'package:goodnews/themes/custom_widget/interaction/custom_circular_progress_indicator.dart';
import 'package:goodnews/view/category_select/category_select_screen.dart';
// import 'package:goodnews/view/login/components/apple_login_button.dart';
import 'package:goodnews/view/login/components/google_login_button.dart';
import 'package:goodnews/service/auth/authentication_service.dart';

import 'package:flutter/material.dart';
import 'package:goodnews/themes/custom_decoration.dart';
import 'package:goodnews/themes/custom_font.dart';
import 'package:goodnews/view/news_category/news_category_screen.dart';
import 'package:goodnews/view_model/auth/auth_provider.dart';
import 'package:goodnews/view_model/auth/components/auth_state.dart';
import 'package:goodnews/view_model/auth/components/auth_state_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
    if (hasAgreed) {
      _handleSigningIn(context, ref, signInMethod: SignInMethod.GOOGLE);
    } else {
      _showAgreementNeeded(context: context);
      return;
    }
    // if (hasAgreed) {
    //   Navigator.push(
    //     context,
    //     CupertinoPageRoute(
    //       builder: (context) => const WebViewExample(signInMethod: SignInMethod.GOOGLE),
    //     ),
    //   );
    // } else {
    //   _showAgreementNeeded(context: context);
    // }

    // if (!hasAgreed) {
    //   _showAgreementNeeded(context: context);
    //   return;
    // }

    // try {
    //   final url = Uri.http('localhost:8080', '/api/login');
    //   final response = await http.get(url);
    //   print('response.statusCode: $response.statusCode');
    //   if (response.statusCode != 200) return;
    //
    //   final loginPageHtml = response.body;
    //   print('loginPageHtml: $loginPageHtml');
    //   // 웹뷰로 로그인 페이지 HTML 전달
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => WebViewExample(html: loginPageHtml),
    //     ),
    //   );
    // } catch (e) {
    //   print('Error: $e');
    // }
  }

  // void _onTappedAppleLogin(BuildContext context, WidgetRef ref) async {
  //   if (hasAgreed) {
  //     _handleSigningIn(context, ref, signInMethod: SignInMethod.APPLE);
  //   } else {
  //     _showAgreementNeeded(context: context);
  //   }
  // }

  void _handleSigningIn(BuildContext context, WidgetRef ref, {SignInMethod? signInMethod}) async {
    final authNotifier = ref.read(authProvider.notifier);

    final res = await authNotifier.signIn(signInMethod);

    if (res == null) {
      logger.e("로그인 실패");
      return; // 로그인 실패 시 함수 종료
    }

    final bool? isProfileComplete = res['isProfileComplete'];

    print('isProfileComplete: $isProfileComplete');

    if (isProfileComplete == null) {
      logger.e("isProfileComplete 값이 null입니다.");
      return;
    }

    if (isProfileComplete) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => NewsCategoryScreen(),
        ),
      );
      return;
    }
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => CategorySelectScreen(),
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

/// 웹뷰 사용한 방식
// class WebViewExample extends StatefulWidget {
//   final String html;
//
//   const WebViewExample({required this.html, Key? key}) : super(key: key);
//
//   @override
//   _WebViewExampleState createState() => _WebViewExampleState();
// }

// class _WebViewExampleState extends State<WebViewExample> {
//   late InAppWebViewController webViewController;
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
//
//   @override
//   Widget build(BuildContext context) {
//     String modifiedHtml = widget.html.replaceAll(
//       '/oauth2/authorization/google',
//       'http:/localhost:8080/oauth2/authorization/google', // Use your actual URL
//     );
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('로그인'),
//       ),
//       body: InAppWebView(
//         initialData: InAppWebViewInitialData(
//           data: modifiedHtml,
//           mimeType: 'text/html',
//           encoding: 'utf-8',
//         ),
//
//         onWebViewCreated: (controller) {
//           webViewController = controller;
//         },
//         onLoadStop: (controller, url) async {
//           print("Page finished loading: $url");
//           // 로그인 성공 후 리다이렉트 URL 감지
//           if (url.toString().contains('/login/oauth2/code/google?state=')) {
//             print("로그인 성공");
//
//             // 페이지의 HTML을 가져와서 body 값을 읽어오기
//             String? htmlContent = await webViewController.getHtml();
//             print('htmlContent: $htmlContent');
//
//             final token = _extractValueFromHtml(htmlContent!, 'token');
//             final isProfileComplete = _extractValueFromHtml(htmlContent!, 'isProfileComplete');
//
//             if (token == null) {
//               print("토큰 추출 실패");
//               Navigator.pop(context); // 웹뷰 닫기
//               return;
//             }
//
//             await _secureStorage.write(key: 'accessToken', value: token); // 토큰 저장
//             await _secureStorage.write(key: 'refreshToken', value: token); // 토큰 저장
//             print("토큰 저장 완료: $token");
//             print("isProfileComplete: $isProfileComplete");
//
//             if (isProfileComplete == null) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => CategorySelectScreen(),
//                 ),
//               );
//               return;
//             }
//
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => NewsCategoryScreen(),
//               ),
//             );
//           }
//         },
//         //아래가 없으면 403 에러 disallowed_useragent가 난다.
//         initialOptions: InAppWebViewGroupOptions(
//           crossPlatform: InAppWebViewOptions(
//             userAgent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/604.1',
//           )
//         ),
//       ),
//     );
//   }
// }

// String? _extractValueFromHtml(String html, String key) {
//   // 정규 표현식을 사용하여 JSON에서 특정 키에 대한 값 추출
//   RegExp regex = RegExp(r'"' + RegExp.escape(key) + r'":\s*"([^"]+)"');
//   Match? match = regex.firstMatch(html);
//
//   if (match != null && match.groupCount > 0) {
//     return match.group(1); // 요청한 키에 대한 값
//   }
//   return null;
// }

// class WebViewExample extends StatelessWidget {
//   final String html;
//
//   const WebViewExample({required this.html, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     String modifiedHtml = html.replaceAll(
//       '/oauth2/authorization/google',
//       'http://localhost:8080/oauth2/authorization/google', // 절대 URL로 변경
//     );
//
//     // WebViewController 생성
//     final WebViewController controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadHtmlString(modifiedHtml)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageFinished: (String url) {
//             // 페이지가 로드 완료된 후의 처리
//             print("Page finished loading: $url");
//             // 로그인 성공 후 리다이렉트 URL 감지
//             if (url.contains('/api/login/success')) {
//               print("url.contains('/api/login/success')");
//               Navigator.pop(context); // 웹뷰 닫기
//               // 추가적인 로그인 성공 처리 로직
//             }
//           },
//         ),
//       );
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('로그인'),
//       ),
//       body: WebViewWidget(controller: controller),
//     );
//   }
// }
