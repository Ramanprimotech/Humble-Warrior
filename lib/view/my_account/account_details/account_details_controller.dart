import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:humble_warrior/hw.dart';

class AccountDetailsController extends GetxController {
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
  }

  Future<void> getData() async {
    userCheck.value =
        await SharePreferenceData.getBoolValuesSF(spIsLogged) ?? false;
    user = await SharePreferenceData.getStringValuesSF(userEmail) ?? "";
    username = await SharePreferenceData.getStringValuesSF(userName) ?? "";
    userPhone =
        await SharePreferenceData.getStringValuesSF(userPhoneNumber) ?? "";
    userImg = await SharePreferenceData.getStringValuesSF(userProfilePic) ?? "";

    if (userPhone == "null") {
      userPhone = "N/A";
    }
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
                Navigator.pop(context);
              },
            ),
            CommonUtils.actionButton(
              galleryTxt,
              onTap: () {
                getImageGallery();
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
