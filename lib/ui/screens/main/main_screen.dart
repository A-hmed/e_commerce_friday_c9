import 'package:e_commerce_friday_c9/ui/screens/main/main_view_model.dart';
import 'package:e_commerce_friday_c9/ui/screens/main/tabs/categories/categories_tab.dart';
import 'package:e_commerce_friday_c9/ui/screens/main/tabs/fav/fav_tab.dart';
import 'package:e_commerce_friday_c9/ui/screens/main/tabs/home/home_tab.dart';
import 'package:e_commerce_friday_c9/ui/screens/main/tabs/profile/profile_tab.dart';
import 'package:e_commerce_friday_c9/ui/shared_view_models/cart_view_model.dart';
import 'package:e_commerce_friday_c9/ui/utils/app_assets.dart';
import 'package:e_commerce_friday_c9/ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = "main";

  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainViewModel viewModel = MainViewModel();

  List<Widget> tabs = const [
    HomeTab(),
    CategoriesTab(),
    FAVTab(),
    ProfileTab(),
  ];

  @override
  void initState() {
    super.initState();
    CartViewModel.get(context).loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: viewModel,
      builder: (context, state) {
        return Scaffold(
          body: tabs[viewModel.currentTabIndex],
          bottomNavigationBar: Theme(
            data: ThemeData(canvasColor: AppColors.primaryColor),
            child: BottomNavigationBar(
              backgroundColor: AppColors.primaryColor,
              unselectedItemColor: AppColors.whiteColor,
              selectedItemColor: AppColors.primaryColor,
              showSelectedLabels: false,
              onTap: (index) {
                viewModel.tabIndex = index;
              },
              iconSize: 35,
              currentIndex: viewModel.currentTabIndex,
              items: [
                buildBottomNavIcon(
                    AppAssets.icHome, viewModel.currentTabIndex == 0),
                buildBottomNavIcon(
                    AppAssets.icCategories, viewModel.currentTabIndex == 1),
                buildBottomNavIcon(
                    AppAssets.icFav, viewModel.currentTabIndex == 2),
                buildBottomNavIcon(
                    AppAssets.icProfile, viewModel.currentTabIndex == 3),
              ],
            ),
          ),
        );
      },
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