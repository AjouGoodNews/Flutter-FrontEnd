import 'package:flutter/material.dart';
import 'package:goodnews/screens/category_select/category_select_screen.dart';
import 'login/login_screen.dart';
import 'login_complete/login_complete_screen.dart';

class RouteScreen extends StatelessWidget {
  const RouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return const LoginScreen();
    return const CategorySelectScreen();
  }
}