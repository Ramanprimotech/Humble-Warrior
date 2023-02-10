import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/view/bottom_navigation/bottom_navigation_controller.dart';

class BottomNavigationScreen extends GetView<BottomNavigationController> {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: GetBuilder(
          init: controller,
          builder: (BottomNavigationController ctr) {
            return Scaffold(
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: BottomNavigationBar(
                    elevation: 10,
                    selectedItemColor: AppColors.primary,
                    unselectedItemColor: Colors.black,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: AppIcons.home(),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: AppIcons.favourite(),
                        label: 'Wish list',
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
                ),
              ),
              body: ctr.navigationItems.elementAt(ctr.selectedIndex),
            );
          }),
    );
  }
}
