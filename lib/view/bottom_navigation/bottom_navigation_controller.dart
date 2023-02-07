import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/view/about_donna/about_screen.dart';
import 'package:humble_warrior/view/home/home_screen.dart';
import 'package:humble_warrior/view/home_option/home_option_screen.dart';

class BottomNavigationController extends GetxController {

  final List<Widget> _navigationItems = [
    const HomeScreen(),
    const Center(child: Text("My Favourite")),
    const Center(child: Text("My Amazone")),
    const Center(child: Text("Join us")),
    const AboutScreen(),
    const Center(child: Text("Account")),
    const HomeOptionScreen()
  ];

  List<Widget> get navigationItems => _navigationItems;

  int selectedIndex = 0;

  void onItemTap(int? index) {
    selectedIndex = index!;
    update();
  }
}
