import 'package:e_commerce_friday_c9/data/model/response/auth_response.dart';
import 'package:e_commerce_friday_c9/data/utils/sharedpref_utils.dart';
import 'package:e_commerce_friday_c9/domain/di/di.dart';
import 'package:e_commerce_friday_c9/ui/screens/auth/login/login.dart';
import 'package:e_commerce_friday_c9/ui/screens/main/main.dart';
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
        ), () async {
      var prefs = getIt<SharedPrefUtils>();
      User? user = await prefs.getUser();
      if (user == null) {
        Navigator.pushNamed(context, Login.routeName);
      } else {
        Navigator.pushNamed(context, MainScreen.routeName);
      }
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
