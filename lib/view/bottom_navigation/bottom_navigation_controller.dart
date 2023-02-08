import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/view/about_donna/about_screen.dart';
import 'package:humble_warrior/view/home/home_screen.dart';
import 'package:humble_warrior/view/productDetail/product_detail_Screen.dart';

class BottomNavigationController extends GetxController {
  final List<Widget> _navigationItems = [
    const HomeScreen(),
    const Center(child: Text("My Favourite")),
    const Center(child: Text("My Amazone")),
    const ProductDetailScreen(),
    const AboutScreen(),
    const Center(child: Text("Account")),
  ];

  List<Widget> get navigationItems => _navigationItems;

  int selectedIndex = 0;

  void onItemTap(int? index) {
    selectedIndex = index!;
    update();
  }
}
