import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:goodnews/enums/sign_in_method.dart';
import 'package:goodnews/service/auth/authentication_service.dart';
import 'package:goodnews/view_model/auth/components/auth_state_provider.dart';

import 'components/auth_state.dart';

final authProvider = StateNotifierProvider((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final AuthenticationService authenticationService = AuthenticationService();
  final Ref ref;

  AuthNotifier(this.ref) : super(null);

  Future<void> checkLoginStatus() async {
    // await secureStorage.delete(key: 'accessToken');
    // await secureStorage.delete(key: 'refreshToken');
    String? accessToken = await secureStorage.read(key: 'accessToken');
    String? refreshToken = await secureStorage.read(key: 'refreshToken');

    if (accessToken != null && refreshToken != null) {
      ref.read(authStateProvider.notifier).state = AuthState.authenticated;
    } else {
      ref.read(authStateProvider.notifier).state = AuthState.unauthenticated;
    }
  }

  Future<Map<String, dynamic>?> signIn(SignInMethod? signInMethod) async {
    try {
      ref.read(authStateProvider.notifier).state = AuthState.loading;

      // bool isSignedIn = await authenticationService.signIn(signInMethod);
      final res = await authenticationService.signIn(signInMethod);

      // if (isSignedIn) {
      //   ref.read(authStateProvider.notifier).state = AuthState.authenticated;
      // } else {
      //   ref.read(authStateProvider.notifier).state = AuthState.unauthenticated;
      // }
      if (res != null && res['isProfileComplete'] != null) {
        ref.read(authStateProvider.notifier).state = AuthState.authenticated;
        return res;
      } else {
        ref.read(authStateProvider.notifier).state = AuthState.unauthenticated;
        return null;
      }
    } catch (e) {
      ref.read(authStateProvider.notifier).state = AuthState.unauthenticated;
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      bool isSignedOut = await authenticationService.signOut();

      if (isSignedOut) {
        ref.read(authStateProvider.notifier).state = AuthState.unauthenticated;
      } else {
        ref.read(authStateProvider.notifier).state = AuthState.authenticated;
      }
    } catch (e) {
      ref.read(authStateProvider.notifier).state = AuthState.authenticated;
    }
  }
}