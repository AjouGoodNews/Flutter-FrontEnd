import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:goodnews/repository/auth/auth_repository.dart';
import 'package:goodnews/service/logger/logger.dart';

class GoogleSignInService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: '787484589868-258tsbj3vogqecahmeblu1q7eqtglnvr.apps.googleusercontent.com');
  final AuthRepository _auth = AuthRepository();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<Map<String, dynamic>?> signIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        logger.e('[구글 로그인] 로그인 취소');
        return null;
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
        return null;
      }

      if (googleIdToken == null) {
        logger.w("구글 idToken 토큰 없음");
        return null;
      }

      final res = await _auth.logIn(googleIdToken);

      final String accessToken = res['accessToken'];
      final bool isProfileComplete = res['isProfileComplete'];

      await _secureStorage.write(key: 'accessToken', value: accessToken);
      // await _secureStorage.write(key: 'refreshToken', value: refreshToken);
      await _secureStorage.write(key: 'refreshToken', value: accessToken);

      UserCredential? userCredential = await _firebaseAuth.signInWithCredential(credential);

      // 로그인 성공 후 사용자 정보 전송
      logger.e("구글 로그인 성공: ${userCredential.user}");
      // await _sendUserInfoToServer(userCredential.user);

      return {
        'accessToken': accessToken,
        'isProfileComplete': isProfileComplete,
      };
    } catch (e) {
      logger.e("구글 로그인 실패", error: e);

      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();

      return null;
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
