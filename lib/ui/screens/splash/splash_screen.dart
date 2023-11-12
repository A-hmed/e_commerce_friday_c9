import 'package:e_commerce_friday_c9/domain/di/di.dart';
import 'package:e_commerce_friday_c9/ui/screens/auth/login/login.dart';
import 'package:e_commerce_friday_c9/ui/screens/main/main.dart';
import 'package:e_commerce_friday_c9/ui/utils/app_assets.dart';
import 'package:e_commerce_friday_c9/ui/utils/shared_prefecences_utils.dart';
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
        ), () async {
      SharedPrefUtils utils = getIt();
      String? token = await utils.getToken();
      if (token == null) {
        Navigator.pushReplacementNamed(context, Login.routeName);
      } else {
        Navigator.pushReplacementNamed(context, MainScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Image.asset(
          AppAssets.splash,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
