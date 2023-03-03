import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/common/common_functionality.dart';
import 'package:humble_warrior/utils/shared_prefrence/shared_pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class AccountDetailsController extends GetxController{

  RxBool userCheck = false.obs;
  String user = "";
  String username = "";
  String userPhone = "";
  String userImg = "";
  File? imagePath;
  RxString imageUrl = "".obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }


  Future<void> getImageCamera() async {
    imagePath =
    await CommonUtils().getImagePath(imageSource: ImageSource.camera);
    imageUrl.value = imagePath!.path;
  }

  Future<void> getImageGallery() async {
    imagePath =
    await CommonUtils().getImagePath(imageSource: ImageSource.gallery);
    imageUrl.value = imagePath!.path;
    debugPrint("Image Pathhh $imagePath");
  }

  Future<void> getData() async {
    userCheck.value =
        await SharePreferenceData.getBoolValuesSF(spIsLogged) ?? false;
    user = await SharePreferenceData.getStringValuesSF(userEmail) ?? "";
    username = await SharePreferenceData.getStringValuesSF(userName) ?? "";
    userPhone = await SharePreferenceData.getStringValuesSF(userPhoneNumber) ?? "";
    userImg = await SharePreferenceData.getStringValuesSF(userProfilePic) ?? "";

    if(userPhone == "null"){
      userPhone = "N/A";
    }
    else{
      print("user phone else  --- $userPhone"); }
  }

  Future<void> openBottomSheet() async {
    return showCupertinoModalPopup<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: CommonUtils.header(),
          actions: <Widget>[
            CommonUtils.actionButton(
              cameraTxt,
              onTap: () {
                getImageCamera();
                //  CommonUtils().getImagePath(imageSource: ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            CommonUtils.actionButton(
              galleryTxt,
              onTap: () {
                getImageGallery();
                //  CommonUtils().getImagePath(imageSource: ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
          ],
          cancelButton: CommonUtils.cancelButton(),
        );
      },
    );
  }

}