import 'dart:io';

import 'package:authentication/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';

import '../../firebase_options.dart';
import '../../utils/shared_prefrence/shared_pref.dart';

class LoginController extends GetxController {
  User? user;
  RxBool platformBool = false.obs;

  checkCurrentPlatform() {
    if (Platform.isAndroid) {
      platformBool.value = false;
      debugPrint("platform -- if --- ${platformBool.value}");
    } else if (Platform.isIOS) {
      platformBool.value = true;
      debugPrint("platform -- else --- ${platformBool.value}");
    }
  }

  @override
  void onInit() {
    checkCurrentPlatform();
    super.onInit();
  }

  /// Click
  Function onClickFunction(
      {required OnClick action, required BuildContext context}) {
    Map<OnClick, void Function()> actions = {
      /// Click  facebook
      OnClick.facebook: () async {
        debugPrint("bbhbhnbnjnjnj");
        try {
          user = await AuthManager().facebookLogin();
          if (user != null) {
            Get.snackbar("Login ", "User Login Successfully ");
            await SharePreferenceData.addBoolToSF(isLogged, true);
            await SharePreferenceData.addStringToSF(userEmail, "${user?.email}");
            await SharePreferenceData.addStringToSF(userPhoneNumber, "${user?.phoneNumber}");
            await SharePreferenceData.addStringToSF(userName, "${user?.displayName}");
            await SharePreferenceData.addStringToSF(userProfilePic, "${user?.photoURL}");
            Get.toNamed(AppRoutes.bottomNavigation);

          }
        } catch (e) {
          debugPrint("error --- $e");
        }
      },

      /// Click Google
      OnClick.google: () async {
        try {
          Loader.show(context);

          user = await AuthManager().googleLogin(
              androidClientId:
                  DefaultFirebaseOptions.currentPlatform.androidClientId ?? "",
              iosClientId:
                  DefaultFirebaseOptions.currentPlatform.iosClientId ?? "");

          if (user != null) {
            Loader.hide();
            Get.snackbar("Login ", "User Login Successfully ");
            await SharePreferenceData.addBoolToSF(isLogged, true);
            await SharePreferenceData.addStringToSF(userEmail, "${user?.email}");
            await SharePreferenceData.addStringToSF(userPhoneNumber, "${user?.phoneNumber}");
            await SharePreferenceData.addStringToSF(userName, "${user?.displayName}");
            await SharePreferenceData.addStringToSF(userProfilePic, "${user?.photoURL}");
            Get.offNamed(AppRoutes.bottomNavigation);

          } else {
            Loader.hide();
          }
        } catch (e) {
          Loader.hide();
          Get.snackbar("Error ", "$e ");
        }
      },

      /// Click apple
      OnClick.apple: () async {
        debugPrint("apple ");
        user = await AuthManager().appleLogin();
        if (user != null) {
          Get.snackbar("Login ", "User Login Successfully ");
          await SharePreferenceData.addBoolToSF(isLogged, true);
          await SharePreferenceData.addStringToSF(userEmail, "${user?.email}");
          await SharePreferenceData.addStringToSF(userPhoneNumber, "${user?.phoneNumber}");
          await SharePreferenceData.addStringToSF(userName, "${user?.displayName}");
          await SharePreferenceData.addStringToSF(userProfilePic, "${user?.photoURL}");
          if(userPhoneNumber.isEmpty || userProfilePic.isEmpty){
            Get.toNamed(AppRoutes.bottomNavigation);
          }
          Get.toNamed(AppRoutes.bottomNavigation);

        }
      },
    };

    Function act = actions[action]!;
    return act;
  }
}

enum OnClick { facebook, google, apple }
