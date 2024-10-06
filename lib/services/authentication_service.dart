import 'package:http/http.dart' as http;
import 'package:goodnews/enums/sign_in_method.dart';
import 'package:goodnews/utils/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthenticationService {
  static final AuthenticationService _instance = AuthenticationService._internal();

  factory AuthenticationService() {
    return _instance;
  }

  AuthenticationService._internal();

  Future<void> signIn({SignInMethod? signInMethod}) async {
    switch (signInMethod) {
      case SignInMethod.GOOGLE:
        await _redirectToGoogleLogin();
        break;
      default:
        throw Exception('login failure');
    }
  }

  Future<void> _redirectToGoogleLogin() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8080/api/login'));

      if (response.statusCode == 200) {
        // 서버에서 로그인 URL을 성공적으로 받아왔으면, 리다이렉트
        final loginUrl = response.request!.url.toString();

        if (await canLaunch(loginUrl)) {
          await launch(loginUrl);
        } else {
          logger.e("리다이렉트 URL을 열 수 없습니다.");
        }
      } else {
        logger.e("로그인 URL을 가져오는 데 실패했습니다. 상태 코드: ${response.statusCode}");
      }
    } catch (e) {
      logger.e("서버와의 통신 중 오류 발생: $e");
    }
  }

  Future<void> _signOutFromGoogle() async {
    // sign out
  }
}
