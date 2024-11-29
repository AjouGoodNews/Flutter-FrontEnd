import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodnews/view/login/login_screen.dart';
import 'package:goodnews/view/route_screen.dart';
import 'package:flutter/material.dart';
import 'package:goodnews/themes/custom_widget/interaction/custom_circular_progress_indicator.dart';
import 'package:goodnews/view_model/auth/auth_provider.dart';
import 'package:goodnews/view_model/auth/components/auth_state.dart';
import 'package:goodnews/view_model/auth/components/auth_state_provider.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late Future<void> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = _initializeApp();
  }

  Future<void> _initializeApp() async {
    await ref.read(authProvider.notifier).checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return MaterialApp(
          title: 'Good News',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.grey,
            ),
          ),
          // themeMode: ThemeMode.system,
          home: FutureBuilder(
            future: _initialization,
            builder: (context, infoSnapshot) {
              if (infoSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: SafeArea(child: CustomCircularProgressIndicator()));
              } else {
                FlutterNativeSplash.remove();

                if (authState == AuthState.authenticated) {
                   return const RouteScreen();
                }
                return const LoginScreen();
              }
            },
          ),
        );
      },
    );
  }
}