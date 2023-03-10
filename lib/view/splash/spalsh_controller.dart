import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/network/api_call.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/helpers/dialog_helper.dart';
import 'package:humble_warrior/utils/shared_prefrence/shared_pref.dart';
import 'package:humble_warrior/utils/token_generator.dart';
import 'package:humble_warrior/view/my_account/circle.dart';
import 'package:humble_warrior/view/my_account/keyboard.dart';
import 'package:humble_warrior/view/my_account/passcode_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../modals/requests/token_model_request.dart';
import '../../network/endpoints.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_themes/app_theme_controller.dart';
import '../../utils/routes/app_routes.dart';

class SplashController extends GetxController {
  final ThemeController themeController = ThemeController();

  late BuildContext context;
  DateTime? currentBackPressTime;
  RxBool isDark = (ThemeMode.system == ThemeMode.dark).obs;
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  getTheme() async {
    var mode = await SharePreferenceData.getBoolValuesSF('mode');
    if (mode == null) {
      await SharePreferenceData.addBoolToSF(
          'mode', ThemeMode.system == ThemeMode.dark);
      isDark.value = ThemeMode.system == ThemeMode.dark;
    } else {
      isDark.value = mode;
    }

    // isDark = themeController.themeMode == ThemeMode.dark;
  }

  Future<void> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(
        "Logged value ---- ${await SharePreferenceData.getBoolValuesSF(spIsLogged)}");
    if (await SharePreferenceData.getBoolValuesSF(spIsLogged) != null) {
      Get.offNamed(AppRoutes.bottomNavigation);
    } else {
      final passCode = sharedPreferences.getString("PASSCODE");
      if (passCode != null) {
        _showLockScreen(
          Get.context!,
          opaque: false,
          cancelButton: const AppText(
            'Cancel',
            fontSize: 16,
          ),
        );
      } else {
        if (await SharePreferenceData.getBoolValuesSF(spIsEntered) == true) {
          Get.offNamed(AppRoutes.bottomNavigation);
        } else {
          Get.offNamed(AppRoutes.loginPage);
        }
      }
    }
  }

  _passcodeEntered(String enteredPasscode) async {
    try {
      if (enteredPasscode != null) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        final storedPassCode = sharedPreferences.getString("PASSCODE");

        if (storedPassCode == enteredPasscode) {
          // Navigator.pop(Get.context!);
          Get.back();
          Get.offAllNamed(AppRoutes.bottomNavigation);
          // Navigator.of(Get.context!).pushNamedAndRemoveUntil(
          //     '/DashbordVC', (Route<dynamic> route) => false);
        } else {
          DialogHelper.showToast(context, 'Incorrect Passcode');
          // Utility().errorToast('Incorrect Passcode', Colors.red);
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
    Get.back();
    SystemNavigator.pop();
    // exit(0);
  }

  _showLockScreen(BuildContext context,
      {required bool opaque,
      CircleUIConfig? circleUIConfig,
      KeyboardUIConfig? keyboardUIConfig,
      Widget? cancelButton,
      List<String>? digits}) {
    Navigator.push(
        context,
        PageRouteBuilder(
            opaque: opaque,
            pageBuilder: (context, animation, secondaryAnimation) =>
                PasscodeScreen(
                  title: const AppText(
                    'Enter Passcode',
                    textAlign: TextAlign.center,
                    fontSize: 28,
                  ),
                  circleUIConfig: circleUIConfig,
                  keyboardUIConfig: keyboardUIConfig,
                  passwordEnteredCallback: _passcodeEntered,
                  cancelButton: cancelButton!,
                  deleteButton: const AppText(
                    'Delete',
                    fontSize: 16,
                  ),
                  shouldTriggerVerification: _verificationNotifier.stream,
                  backgroundColor: Colors.black.withOpacity(0.8),
                  cancelCallback: _passcodeCancelled,
                  digits: digits,
                  passwordDigits: 6,
                )));
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
