import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/view/bottom_navigation/bottom_navigation_controller.dart';

class BottomNavigationScreen extends GetView<BottomNavigationController> {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (BottomNavigationController ctr) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: AppIcons.home(),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: AppIcons.favourite(),
                  label: 'My favourite',
                ),
                BottomNavigationBarItem(
                  icon: AppIcons.bag(),
                  label: 'My Amazon',
                ),
                BottomNavigationBarItem(
                  icon: AppIcons.join(),
                  label: 'Join Us',
                ),
                BottomNavigationBarItem(
                  icon: AppIcons.person(),
                  label: 'Account',
                ),
              ],
              currentIndex: ctr.selectedIndex,
              onTap: ctr.onItemTap,
            ),
            body: ctr.navigationItems.elementAt(ctr.selectedIndex),
          );
        });
  }
}
