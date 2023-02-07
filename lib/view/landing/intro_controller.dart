import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:velocity_x/velocity_x.dart';

import 'intro_screen.dart';

class IntroScreenController extends GetxController{
  final pageController = PageController();

  RxInt currentIndex = 0.obs;

  void skipFunc(){
    pageController.jumpToBottom();
  }
  void startFunc(){
    Get.toNamed(AppRoutes.loginPage);
  }
  void nextFunc(){
    pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut);
  }

}