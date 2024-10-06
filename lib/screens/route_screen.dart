import 'package:flutter/material.dart';
import 'login/login_screen.dart';

class RouteScreen extends StatelessWidget {
  const RouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 여기서 사용자 인증을 체크하고 TabScreen 또는 LoginScreen을 반환하는 로직을 제거했습니다.
    return const LoginScreen();
  }
}