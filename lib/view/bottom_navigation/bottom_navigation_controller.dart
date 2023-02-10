import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/view/home/home_screen.dart';
import 'package:humble_warrior/view/join_us_facebook/facebook.dart';
import 'package:humble_warrior/view/my_amazone/amazone.dart';

import '../../utils/app_strings.dart';
import '../../utils/shared_prefrence/shared_pref.dart';
import '../my_account/my_account_screen.dart';

class BottomNavigationController extends GetxController {
  final List<Widget> _navigationItems = [
    const HomeScreen(),
    const Center(child: Text("My Favourite")),
    const AmazonWebView(),
    const FaceBookWebView(),
    const MyAccount(),
  ];

  List<Widget> get navigationItems => _navigationItems;

  int selectedIndex = 0;
  bool value = false;
  String? user;

  void onItemTap(int? index) {
    selectedIndex = index!;
    update();
  }

  Future<void> getLoggedValue() async {
    value = await SharePreferenceData.getBoolValuesSF(isLogged) ?? false;
    user = await SharePreferenceData.getStringValuesSF(userEmail) ?? "";
    debugPrint("Logged Value ---- $value --- user --- $user");
  }

  @override
  void onInit() {
    getLoggedValue();
    super.onInit();
  }
}
