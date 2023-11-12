import 'package:e_commerce_friday_c9/domain/di/di.dart';
import 'package:e_commerce_friday_c9/ui/cubits/cart_cubit.dart';
import 'package:e_commerce_friday_c9/ui/screens/auth/login/login.dart';
import 'package:e_commerce_friday_c9/ui/screens/auth/register/register.dart';
import 'package:e_commerce_friday_c9/ui/screens/cart/cart.dart';
import 'package:e_commerce_friday_c9/ui/screens/main/main.dart';
import 'package:e_commerce_friday_c9/ui/screens/product_details/product_details.dart';
import 'package:e_commerce_friday_c9/ui/screens/splash/splash_screen.dart';
import 'package:e_commerce_friday_c9/ui/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  configureDependencies();
  runApp(BlocProvider(create: (_) => getIt<CartCubit>(), child: const MyApp()));
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
        MainScreen.routeName: (_) => MainScreen(),
        CartScreen.routeName: (_) => CartScreen(),
        ProductDetails.routeName: (_) {
          return ProductDetails();
        }
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
