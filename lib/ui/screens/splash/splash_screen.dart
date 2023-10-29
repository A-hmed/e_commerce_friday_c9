
import 'package:e_commerce_friday_c9/ui/screens/auth/login/login.dart';
import 'package:e_commerce_friday_c9/ui/utils/app_assets.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(
          seconds: 2,
        ), () {
      Navigator.pushNamed(context, Login.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Image.asset(AppAssets.splash,
          width: double.infinity,
          fit: BoxFit.fill,),
      ),
    );
  }
}
