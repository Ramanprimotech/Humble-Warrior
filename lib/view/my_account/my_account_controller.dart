import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/common/common_functionality.dart';
import 'package:image_picker/image_picker.dart';

class MyAccountController extends GetxController{

  RxBool check = true.obs;
  RxBool checkNotification = true.obs;
  RxBool checkDark = true.obs;
  RxBool isSwitch = false.obs;

  // Rx<File?> imagePath = File("").obs;
  File? imagePath;
  RxString imageUrl = "".obs;
  Future<void> getImageGallery() async {
    imagePath = await CommonUtils().getImagePath(imageSource:ImageSource.gallery);
    imageUrl.value = imagePath!.path;
    debugPrint("Image Pathhh $imagePath");
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

}