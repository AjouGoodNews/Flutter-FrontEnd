import 'package:flutter/material.dart';
import 'login/login_screen.dart';
import 'login_complete/login_complete_screen.dart';

class RouteScreen extends StatelessWidget {
  const RouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return const LoginScreen();
    return const LoginCompleteScreen();
  }
}