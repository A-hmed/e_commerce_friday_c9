import 'package:e_commerce_friday_c9/ui/screens/main/tabs/categories/categories_tab.dart';
import 'package:e_commerce_friday_c9/ui/screens/main/tabs/fav/fav_tab.dart';
import 'package:e_commerce_friday_c9/ui/screens/main/tabs/home/home_tab.dart';
import 'package:e_commerce_friday_c9/ui/screens/main/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainViewModel extends Cubit {
  MainViewModel() : super(MainInitialState());
  int currentTabIndex = 0;
  List<Widget> tabs = [
    HomeTab(),
    CategoriesTab(),
    FAVTab(),
    ProfileTab(),
  ];

  set currentTab(int newIndex) {
    print("newIndex: $newIndex");
    currentTabIndex = newIndex;
    emit(MainInitialState());
  }
}

class MainInitialState {}
