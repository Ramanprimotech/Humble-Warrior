import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_themes/app_theme_controller.dart';
import 'package:humble_warrior/utils/common/common_functionality.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/app_strings.dart';
import '../../utils/routes/app_routes.dart';
import '../../utils/shared_prefrence/shared_pref.dart';

class MyAccountController extends GetxController{

  RxBool check = true.obs;
  RxBool checkNotification = true.obs;
  RxBool checkDark = false.obs;
  RxBool isSwitch = false.obs;
  RxBool userCheck = false.obs;
  String user = "";
  String username = "";
  String userPhone = "";
  String userImg = "";
  ThemeController themeController = Get.find();

  // Rx<File?> imagePath = File("").obs;
  File? imagePath;
  RxString imageUrl = "".obs;
  Future<void> getImageGallery() async {
    imagePath = await CommonUtils().getImagePath(imageSource:ImageSource.gallery);
    imageUrl.value = imagePath!.path;
    debugPrint("Image Pathhh $imagePath");
  }

  Future<void> getData() async {
    userCheck.value = await SharePreferenceData.getBoolValuesSF(isLogged) ?? false;
    user = await SharePreferenceData.getStringValuesSF(userEmail) ?? "";
    username = await SharePreferenceData.getStringValuesSF(userName) ?? "";
    userPhone = await SharePreferenceData.getStringValuesSF(userPhoneNumber) ?? "";
    userImg = await SharePreferenceData.getStringValuesSF(userProfilePic) ?? "";
    debugPrint("user data ---- $username ---- $userPhone ---- $userImg");
  }

  Future<void> getImageCamera() async {
    imagePath = await CommonUtils().getImagePath(imageSource:ImageSource.camera);
    imageUrl.value = imagePath!.path;
  }

  void switchFunc(){
    checkNotification.value = !checkNotification.value;

  }

  void darkMode(){
    checkDark.value = !checkDark.value;
    //themeController.changeTheme(check.value);
    Get.changeThemeMode(checkDark.value ? ThemeMode.dark : ThemeMode.light);
    themeController.upgradeFun(checkDark.value);
    themeController
        .setThemeMode(checkDark.value ? ThemeMode.dark : ThemeMode.light);

    SharePreferenceData.addBoolToSF("mode", checkDark.value);
    update();


  }

  Future<void>logout() async {
    await FirebaseAuth.instance.signOut().then((value) async {  await SharePreferenceData.clear();
     Get.offAllNamed(AppRoutes.loginPage);
    });
  }

   loginPage(){
    Get.offAllNamed(AppRoutes.loginPage);
  }


  @override
  void onInit() {
  checkDark.value=    themeController.themeMode == ThemeMode.dark;
    getData();
    super.onInit();
  }

}