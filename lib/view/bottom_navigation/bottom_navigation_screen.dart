import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/theme_extention/image_icon_theme_extention.dart';
import 'package:humble_warrior/utils/theme_extention/shadow_theme_extention.dart';
import 'package:humble_warrior/view/bottom_navigation/bottom_navigation_controller.dart';

class BottomNavigationScreen extends GetView<BottomNavigationController> {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageIconTheme imageIconTheme = Theme.of(context).extension<ImageIconTheme>()!;
    final Color iconColor = imageIconTheme.backGroundColor!;
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
                      icon: AppIcons.unselectedHome(context , iconColor),
                      activeIcon: AppIcons.home(context),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: AppIcons.unselectedfavourite(context, iconColor),
                      activeIcon: AppIcons.favourite(context),
                      label: 'My Wishlist',
                    ),
                    BottomNavigationBarItem(
                      icon: AppIcons.unselectedCheck(context, iconColor),
                      activeIcon: AppIcons.check(context),
                      label: 'My Amazon',
                    ),
                    BottomNavigationBarItem(
                      icon: AppIcons.unselectedJoin(context, iconColor),
                      activeIcon: AppIcons.join(context),
                      label: 'Join Us',
                    ),
                    BottomNavigationBarItem(
                      icon: AppIcons.unselectedPerson(context, iconColor),
                      activeIcon: AppIcons.person(context),
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
