import 'package:e_commerce_friday_c9/ui/cubits/cart_cubit.dart';
import 'package:e_commerce_friday_c9/ui/screens/cart/cart.dart';
import 'package:e_commerce_friday_c9/ui/screens/main/main_view_model.dart';
import 'package:e_commerce_friday_c9/ui/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/app_color.dart';

class MainScreen extends StatefulWidget {
  static String routeName = "home";

  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainViewModel viewModel = MainViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CartCubit cartCubit = BlocProvider.of(context);
    cartCubit.loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder(
        bloc: viewModel,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, CartScreen.routeName);
                    },
                    child: const Icon(
                      Icons.shopping_cart,
                      color: AppColors.primaryColor,
                    ))
              ],
            ),
            body: viewModel.tabs[viewModel.currentSelectedTab],
            bottomNavigationBar: Theme(
              data: ThemeData(canvasColor: AppColors.primaryColor),
              child: BottomNavigationBar(
                unselectedItemColor: AppColors.whiteColor,
                selectedItemColor: AppColors.primaryColor,
                onTap: (index) {
                  viewModel.setCurrentSelectedTab(index);
                },
                iconSize: 35,
                currentIndex: viewModel.currentSelectedTab,
                items: [
                  buildBottomNavIcon(
                      AppAssets.icHome, viewModel.currentSelectedTab == 0),
                  buildBottomNavIcon(AppAssets.icCategories,
                      viewModel.currentSelectedTab == 1),
                  buildBottomNavIcon(
                      AppAssets.icFav, viewModel.currentSelectedTab == 2),
                  buildBottomNavIcon(
                      AppAssets.icProfile, viewModel.currentSelectedTab == 3),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  buildBottomNavIcon(String asset, bool selected) {
    return BottomNavigationBarItem(
        icon: selected
            ? CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: ImageIcon(
              AssetImage(asset),
              size: 30,
            ))
            : ImageIcon(AssetImage(asset), size: 30),
        label: "");
  }
}
