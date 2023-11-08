import 'package:e_commerce_friday_c9/ui/screens/main/main_view_model.dart';
import 'package:e_commerce_friday_c9/ui/utils/app_assets.dart';
import 'package:e_commerce_friday_c9/ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  static const String routeName = "main";
  MainViewModel viewModel = MainViewModel();

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: viewModel,
        builder: (context, _) {
          return Scaffold(
            body: viewModel.tabs[viewModel.currentTabIndex],
            bottomNavigationBar: Theme(
              data: ThemeData(canvasColor: AppColors.primaryColor),
              child: BottomNavigationBar(
                backgroundColor: AppColors.primaryColor,
                unselectedItemColor: AppColors.whiteColor,
                selectedItemColor: AppColors.primaryColor,
                showSelectedLabels: false,
                onTap: (index) {
                  viewModel.currentTab = index;
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
        });
  }

  buildBottomNavIcon(String asset, bool selected) {
    return BottomNavigationBarItem(
        icon: selected
            ? CircleAvatar(
                radius: selected ? 20 : 0,
                backgroundColor: selected ? Colors.white : Colors.transparent,
                child: ImageIcon(
                  AssetImage(asset),
                  size: 30,
                ))
            : ImageIcon(AssetImage(asset), size: 30),
        label: "");
  }
}
