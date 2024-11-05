import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:goodnews/repository/auth/auth_repository.dart';
import 'package:goodnews/service/logger/logger.dart';

class GoogleSignInService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final AuthRepository _auth = AuthRepository();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<bool> signIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        logger.e('[구글 로그인] 로그인 취소');
        return false;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final String? googleAccessToken = googleAuth.accessToken;
      final String? googleIdToken = googleAuth.idToken;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAccessToken,
        idToken: googleIdToken,
      );

      if (googleAccessToken == null) {
        logger.w("구글 액세스 토큰 없음");
        return false;
      }

      final tokens = await _auth.logIn(googleAccessToken);

      final String accessToken = tokens['accessToken']!;
      final String refreshToken = tokens['refreshToken']!;

      await _secureStorage.write(key: 'accessToken', value: accessToken);
      await _secureStorage.write(key: 'refreshToken', value: refreshToken);

      UserCredential? userCredential = await _firebaseAuth.signInWithCredential(credential);

      // 로그인 성공 후 사용자 정보 전송
      logger.e("구글 로그인 성공: ${userCredential.user}");
      // await _sendUserInfoToServer(userCredential.user);

      return true;
    } catch (e) {
      logger.e("구글 로그인 실패", error: e);

      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();

      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      logger.i("로그아웃 시도");

      final String? refreshToken = await _secureStorage.read(key: 'refreshToken');

      if (refreshToken != null) {
        await _auth.logOut(refreshToken);

        return true;
      }

      logger.w("리프레쉬 토큰 없음");

      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      await _secureStorage.deleteAll();

      return false;
    } catch (e) {
      logger.e("로그아웃 실패", error: e);

      return false;
    }
  }
}

// 사용자 정보를 서버에 전송하는 메서드
// Future<void> _sendUserInfoToServer(User? user) async {
//   if (user == null) return;
//
//   final url = Uri.http('10.0.2.2:8080', '/api/login/success');
//   final response = await http.post(
//       url,
//       headers: { "Content-Type": "application/json" },
//       body: json.encode({'email': user.email, 'name': user.displayName})
//   );
//
//   // if (response.statusCode == 200) {
//   //   logger.i('서버와의 통신 성공: ${response}');
//   // } else {
//   //   logger.e('서버와의 통신 실패: ${response.statusCode}');
//   // }
//   if (response.statusCode == 200) {
//     logger.i('서버와의 통신 성공: ${response}');
//   } else if (response.statusCode == 302) {
//     // 리다이렉션 처리
//     final redirectUrl = response.headers['location'];
//     if (redirectUrl != null) {
//       logger.i('리다이렉트: $redirectUrl');
//       // 필요한 경우 여기서 리다이렉션 요청을 추가로 보낼 수 있습니다.
//     }
//   } else {
//     logger.e('서버와의 통신 실패: ${response.statusCode}');
//   }
// }