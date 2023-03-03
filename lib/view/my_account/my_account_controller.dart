import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_themes/app_theme_controller.dart';
import 'package:humble_warrior/utils/common/common_functionality.dart';
import 'package:humble_warrior/utils/helpers/dialog_helper.dart';
import 'package:humble_warrior/view/my_account/circle.dart';
import 'package:humble_warrior/view/my_account/keyboard.dart';
import 'package:humble_warrior/view/my_account/passcode_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_strings.dart';
import '../../utils/routes/app_routes.dart';
import '../../utils/shared_prefrence/shared_pref.dart';

class MyAccountController extends GetxController {
  RxBool check = true.obs;
  RxBool checkNotification = true.obs;
  RxBool checkDark = false.obs;
  RxBool isSwitch = false.obs;
  RxBool userCheck = false.obs;
  String user = "";
  String username = "";
  String userPhone = "";
  String userImg = "";
  late BuildContext context;
  ThemeController themeController = Get.find();
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  // Rx<File?> imagePath = File("").obs;
  File? imagePath;
  RxString imageUrl = "".obs;
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
    userPhone =
        await SharePreferenceData.getStringValuesSF(userPhoneNumber) ?? "";
    userImg = await SharePreferenceData.getStringValuesSF(userProfilePic) ?? "";
    debugPrint("user data ---- $username ---- $userPhone ---- $userImg");
  }

  void message(context){
    DialogHelper.showToast(context, "Stay tuned");
  }

  Future<void> getImageCamera() async {
    imagePath =
        await CommonUtils().getImagePath(imageSource: ImageSource.camera);
    imageUrl.value = imagePath!.path;
  }

  void switchFunc() {
    checkNotification.value = !checkNotification.value;
  }

  void darkMode() {
    checkDark.value = !checkDark.value;
    //themeController.changeTheme(check.value);
    Get.changeThemeMode(checkDark.value ? ThemeMode.dark : ThemeMode.light);
    themeController.upgradeFun(checkDark.value);
    themeController
        .setThemeMode(checkDark.value ? ThemeMode.dark : ThemeMode.light);

    SharePreferenceData.addBoolToSF("mode", checkDark.value);
    update();
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut().then((value) async {
      await SharePreferenceData.clear();
      await SharePreferenceData.addBoolToSF(spIsEntered, false);
      Get.offAllNamed(AppRoutes.loginPage);
    });
  }

  loginPage() {
    Get.offAllNamed(AppRoutes.loginPage);
  }

  @override
  void onInit() {
    checkDark.value = themeController.themeMode == ThemeMode.dark;
    getData();
    super.onInit();
  }

  void tapPasscode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var pass = sharedPreferences.getString('PASSCODE');
    if (pass == null || pass == "") {
      _showLockScreen(
        Get.context!,
        opaque: false,
        cancelButton: Text(
          'Cancel',
          style: TextStyle(
            fontSize: 16,
            // color: (AppMode.darkMode == true) ? Colors.white : Colors.black,
            color: Colors.white,
          ),
          semanticsLabel: 'Cancel',
        ),
      );
    } else {
      DialogHelper.showConfirmationDialog(
          message: "Do you want to Change Or Remove the Passcode",
          cancelLabel: "Change",
          actionLabel: "Remove",
          cancelAction: () async {
            Get.back();
            await _showLockScreen(
              Get.context!,
              opaque: false,
              cancelButton: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.red,
                ),
                semanticsLabel: 'Cancel',
              ),
            );
          },
          action: () async {
            // Navigator.of(Get.context!, rootNavigator: true).pop();
            Get.back(result: true);
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();

            var pass = sharedPreferences.getString('PASSCODE');
            if (pass == null || pass == "") {
              DialogHelper.showToast(context, 'Passcode not set yet');
            } else {
              sharedPreferences.remove('PASSCODE');
              DialogHelper.showToast(context, 'Successfully removed passcode');
            }
          },
          context: Get.context!);
    }
  }

  _showLockScreen(
    BuildContext context, {
    required bool opaque,
    CircleUIConfig? circleUIConfig,
    KeyboardUIConfig? keyboardUIConfig,
    Widget? cancelButton,
    List<String>? digits,
  }) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: opaque,
        pageBuilder: (context, animation, secondaryAnimation) => PasscodeScreen(
          title: Text(
            'Set Passcode',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          circleUIConfig: circleUIConfig,
          keyboardUIConfig: keyboardUIConfig,
          passwordEnteredCallback: _passcodeEntered,
          // cancelButton: cancelButton!,
          cancelButton: cancelButton!,
          deleteButton: Text(
            'Delete',
            style: const TextStyle(fontSize: 16, color: Colors.white),
            semanticsLabel: 'Delete',
          ),
          shouldTriggerVerification: _verificationNotifier.stream,
          backgroundColor: Colors.black.withOpacity(0.8),
          cancelCallback: _passcodeCancelled,
          digits: digits,
          passwordDigits: 6,
        ),
      ),
    );
  }

  _passcodeEntered(String enteredPasscode) async {
    try {
      if (enteredPasscode != null) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('PASSCODE', enteredPasscode);

        if (sharedPreferences.getString('PASSCODE') != null) {
          // DialogHelper.showToast(Get.context!, 'Successfully set app passcode',);
          DialogHelper.showAlertDialog(
            'Successfully set app passcode',
            onTap: () {
              Get.back(result: true);
              Get.back(result: true);
              // Navigator.of(Get.context!, rootNavigator: true).pop();
              // Navigator.of(Get.context!, rootNavigator: true).pop();
            },
          );
        } else {
          // DialogHelper.showToast(Get.context!, 'Successfully set app passcode',);
          DialogHelper.showAlertDialog(
            'Successfully reset app passcode',
            onTap: () {
              Get.back(result: true);
              Get.back(result: true);
              // Navigator.of(context, rootNavigator: true).pop();
              // Navigator.of(context, rootNavigator: true).pop();
            },
          );
        }
      }
      return;
    } catch (err) {
      DialogHelper.showErrorDialog();
      // Utility().errorToast(AppMessages.defaultError, Colors.red);
      return;
    }
  }

  _passcodeCancelled() {
    Navigator.maybePop(Get.context!);
  }
}
