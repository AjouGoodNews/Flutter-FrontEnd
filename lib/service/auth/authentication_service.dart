import 'package:goodnews/enums/sign_in_method.dart';
import 'package:goodnews/service/auth/apple_sign_in_service.dart';
import 'package:goodnews/service/auth/google_sign_in_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  static final AuthenticationService _instance = AuthenticationService._internal();

  factory AuthenticationService() {
    return _instance;
  }

  AuthenticationService._internal();

  final GoogleSignInService _googleSignInService = GoogleSignInService();
  final AppleSignInService _appleSignInService = AppleSignInService();

  List<SignInMethod> get signInMethods => _getCurrentLoginPlatform();

  Future<Map<String, dynamic>?> signIn(SignInMethod? signInMethod) async {
    switch (signInMethod) {
      case SignInMethod.GOOGLE:
        return await _googleSignInService.signIn();
      // case SignInMethod.APPLE:
      //   return await _appleSignInService.signIn();
      default:
        throw Exception('login failure');
    }
  }

  Future<bool> signOut() async {
    List<SignInMethod> signInMethods = _getCurrentLoginPlatform();

    // Google/Apple 로그인 동시 사용에 경우 Google 로그아웃을 시도
    switch (signInMethods.first) {
      case SignInMethod.APPLE:
        return await _googleSignInService.signOut();
      case SignInMethod.GOOGLE:
        return await _appleSignInService.signOut();
    }
  }
}

extension Utils on AuthenticationService {
  List<SignInMethod> _getCurrentLoginPlatform() {
    User user = FirebaseAuth.instance.currentUser!;
    List<UserInfo> providerData = user.providerData;
    List<SignInMethod> currentSignInMethods = [];

    for (var element in providerData) {
      for (var platform in SignInMethod.values) {
        if (platform.domain == element.providerId) {
          currentSignInMethods.add(platform);
        }
      }
    }

    return currentSignInMethods;
  }
}