import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/common/common_functionality.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

import '../../utils/app_strings.dart';
import '../../utils/shared_prefrence/shared_pref.dart';

class MyAccountController extends GetxController{

  RxBool check = true.obs;
  RxBool checkNotification = true.obs;
  RxBool checkDark = true.obs;
  RxBool isSwitch = false.obs;
  bool userCheck = false;
  String user = "";
  String username = "";
  String userPhone = "";
  String userImg = "";

  // Rx<File?> imagePath = File("").obs;
  File? imagePath;
  RxString imageUrl = "".obs;
  Future<void> getImageGallery() async {
    imagePath = await CommonUtils().getImagePath(imageSource:ImageSource.gallery);
    imageUrl.value = imagePath!.path;
    debugPrint("Image Pathhh $imagePath");
  }

  Future<void> getData() async {
    userCheck = await SharePreferenceData.getBoolValuesSF(isLogged) ?? false;
    user = await SharePreferenceData.getStringValuesSF(userEmail) ?? "";
    username = await SharePreferenceData.getStringValuesSF(userName) ?? "";
    userPhone = await SharePreferenceData.getStringValuesSF(userPhoneNumber) ?? "";
    userImg = await SharePreferenceData.getStringValuesSF(userProfilePic) ?? "";
    print("user data ---- ${username} ---- ${userPhone} ---- ${userImg}");
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
  }
  @override
  void onInit() {
    getData();
    super.onInit();
  }

}