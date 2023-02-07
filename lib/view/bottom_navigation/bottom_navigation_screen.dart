import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outlined),
                  label: 'My favourite',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag),
                  label: 'My Amazon',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.facebook),
                  label: 'Join Us',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_rounded),
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
