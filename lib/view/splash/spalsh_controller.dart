import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/network/api_call.dart';
import 'package:humble_warrior/utils/helpers/dialog_helper.dart';
import 'package:humble_warrior/utils/shared_prefrence/shared_pref.dart';
import 'package:humble_warrior/utils/token_generator.dart';

import '../../modals/requests/token_model_request.dart';
import '../../network/endpoints.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_themes/app_theme_controller.dart';
import '../../utils/routes/app_routes.dart';

class SplashController extends GetxController {
  final ThemeController themeController = ThemeController();

  RxBool isDark = false.obs;

  getTheme() async {
    isDark.value = await SharePreferenceData.getBoolValuesSF('mode') ??
        ThemeMode.system == ThemeMode.dark;
    // isDark = themeController.themeMode == ThemeMode.dark;
  }

  Future<void> getData() async {
    print(
        "Logged value ---- ${await SharePreferenceData.getBoolValuesSF(isLogged)}");
    if (await SharePreferenceData.getBoolValuesSF(isLogged) != null) {
      Get.offNamed(AppRoutes.bottomNavigation);
    } else {
      Get.offNamed(AppRoutes.loginPage);
    }
  }

  @override
  void onInit() async {
    await getTheme();
    Future.delayed(const Duration(seconds: 3), () {
      getData();
    });
    TokenManager(onTokenGenerate: () {}, onTokenEror: showError).init();
    super.onInit();
  }

  void showError() {
    DialogHelper.showErrorDialog();
  }

  Future<bool> generateToken() async {
    TokenRequestModel tokenRequestModel = TokenRequestModel(userid: "4"

        // username: "info@newjerseymultimedia.com",
        // password: "JtB@zCajal87@7MVXjzfyxOd"
        );
    await CallAPI.generateToken(payload: tokenRequestModel).then((value) {
      log("${value.token}", name: "Token API");
      if (value.token == null) {
        return false;
      }
      Endpoints.token = value.token.toString();
      log(value.token.toString());
      log(Endpoints.token.toString());
    });
    return true;
  }
}
