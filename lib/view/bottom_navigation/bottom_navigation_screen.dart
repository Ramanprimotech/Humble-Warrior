import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/theme_extention/shadow_theme_extention.dart';
import 'package:humble_warrior/view/bottom_navigation/bottom_navigation_controller.dart';

class BottomNavigationScreen extends GetView<BottomNavigationController> {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ShadowTheme shadowTheme = Theme.of(context).extension<ShadowTheme>()!;
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: GetBuilder(
          init: controller,
          builder: (BottomNavigationController ctr) {
            return Scaffold(
              bottomNavigationBar: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 2,
                    color: shadowTheme.shadowColor!,
                  ),
                ]),
                child: BottomNavigationBar(
                  elevation: 10,
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
              body: ctr.navigationItems.elementAt(ctr.selectedIndex),
            );
          }),
    );
  }
}
