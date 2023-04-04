import 'dart:io';

import 'package:humble_warrior/hw.dart';

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
      await SharePreferenceData.addBoolToSF('mode', false);
      isDark.value = false;
    } else {
      isDark.value = mode;
    }
  }

  Future<void> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

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
      if (await SharePreferenceData.getBoolValuesSF(spIsLogged) == true) {
        Get.offNamed(AppRoutes.bottomNavigation);
      } else {
        if (await SharePreferenceData.getBoolValuesSF(spIsEntered) == true) {
          Get.offNamed(AppRoutes.bottomNavigation);
        } else {
          Get.offNamed(AppRoutes.loginPage);
        }
      }
    }
    // }
  }

  _passcodeEntered(String enteredPasscode) async {
    try {
      if (enteredPasscode != null) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        final storedPassCode = sharedPreferences.getString("PASSCODE");

        if (storedPassCode == enteredPasscode) {
          Get.back();
          if (await SharePreferenceData.getBoolValuesSF(spIsLogged) == true) {
            Get.offNamed(AppRoutes.bottomNavigation);
          } else {
            if (await SharePreferenceData.getBoolValuesSF(spIsEntered) ==
                true) {
              Get.offNamed(AppRoutes.bottomNavigation);
            } else {
              Get.offNamed(AppRoutes.loginPage);
            }
          }
        } else {
          DialogHelper.showToast(context, 'Incorrect Passcode');
        }
      }
      return;
    } catch (err) {
      DialogHelper.showErrorDialog();
      return;
    }
  }

  _passcodeCancelled() {
    Get.back();
    exit(0);
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
      if (value.token == null) {
        return false;
      }
      Endpoints.token = value.token.toString();
    });
    return true;
  }
}
