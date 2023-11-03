import 'package:e_commerce_friday_c9/domain/di/di.dart';
import 'package:e_commerce_friday_c9/ui/screens/auth/login/login.dart';
import 'package:e_commerce_friday_c9/ui/screens/auth/register/register.dart';
import 'package:e_commerce_friday_c9/ui/screens/home/home.dart';
import 'package:e_commerce_friday_c9/ui/screens/splash/splash_screen.dart';
import 'package:e_commerce_friday_c9/ui/utils/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.lightTheme,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        Login.routeName: (_) => Login(),
        Register.routeName: (_) => Register(),
        Home.routeName: (_) => Home(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}

