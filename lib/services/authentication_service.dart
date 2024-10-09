import 'dart:convert';

import 'package:goodnews/enums/sign_in_method.dart';
import 'package:goodnews/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  static final AuthenticationService _instance = AuthenticationService._internal();

  factory AuthenticationService() {
    return _instance;
  }

  AuthenticationService._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  List<SignInMethod> get signInMethods => _getCurrentLoginPlatform();

  Future<UserCredential?> signIn({SignInMethod? signInMethod}) async {
    switch (signInMethod) {
      case SignInMethod.GOOGLE:
        return await _signInWithGoogle();
      case SignInMethod.APPLE:
        return await _signInWithApple();
      default:
        throw Exception('login failure');
    }
  }

  // 사용자 정보를 서버에 전송하는 메서드
  Future<void> _sendUserInfoToServer(User? user) async {
    if (user == null) return;

    final url = Uri.http('10.0.2.2:8080', '/api/login/success');
    final response = await http.post(
        url,
        headers: { "Content-Type": "application/json" },
        body: json.encode({'email': user.email, 'name': user.displayName})
    );

    // if (response.statusCode == 200) {
    //   logger.i('서버와의 통신 성공: ${response}');
    // } else {
    //   logger.e('서버와의 통신 실패: ${response.statusCode}');
    // }
    if (response.statusCode == 200) {
      logger.i('서버와의 통신 성공: ${response}');
    } else if (response.statusCode == 302) {
      // 리다이렉션 처리
      final redirectUrl = response.headers['location'];
      if (redirectUrl != null) {
        logger.i('리다이렉트: $redirectUrl');
        // 필요한 경우 여기서 리다이렉션 요청을 추가로 보낼 수 있습니다.
      }
    } else {
      logger.e('서버와의 통신 실패: ${response.statusCode}');
    }
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      UserCredential? userCredential;
      final googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount == null) {
        logger.e('[구글 로그인] 로그인 취소');
        return null; // 로그인 취소 시 null 반환
      }

      final googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      userCredential = await _firebaseAuth.signInWithCredential(credential);

      // 로그인 성공 후 사용자 정보 전송
      logger.e("구글 로그인 성공: ${userCredential.user}");
      await _sendUserInfoToServer(userCredential.user);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      logger.e("파이어베이스 구글 로그인 에러.\n$e");
      rethrow;
    }
  }

  Future<UserCredential> _signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final AuthCredential credential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      logger.e("파이어베이스 애플 로그인 에러.\n$e");
      rethrow;
    }
  }

  Future<void> signOut() async {
    List<SignInMethod> signInMethods = _getCurrentLoginPlatform();

    // Google/Apple 로그인 동시 사용에 경우 Google 로그아웃을 시도
    switch (signInMethods.first) {
      case SignInMethod.APPLE:
        await _signOutFromApple();
        break;
      case SignInMethod.GOOGLE:
        await _signOutFromGoogle();
        break;
    }

    await _firebaseAuth.signOut();
  }

  Future<void> _signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  Future<void> _signOutFromApple() async {
    await _firebaseAuth.signOut();
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