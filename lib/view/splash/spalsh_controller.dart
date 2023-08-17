import 'dart:convert';
import 'dart:io';
import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/response/version_response_modal.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;

class SplashController extends GetxController {
  final ThemeController themeController = ThemeController();

  VersionResponse data = VersionResponse();
  bool canNavigateInside = false;
  String version = "";
  String code = "";

  late BuildContext context;
  DateTime? currentBackPressTime;
  RxBool isDark = (ThemeMode.system == ThemeMode.dark).obs;
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  /// Splash timer
  startTime() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, getData);
  }

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
    // DialogHelper.showLoadingDialog(
    //   label: '', showLabel: false,);
    await CommonUtils.toCheckInternet(
      context: context,
      action: () async {
        await checkVersion(version: version).then((value) async {
          canNavigateInside = true;
          if(value == true){
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
          }
          else {
            DialogHelper.closeDialog();
            _showDialog(context);
          }
          DialogHelper.closeDialog();
        });
      }
    );
  }

  packageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    code = packageInfo.buildNumber;
    print("version ${version}");
    print("build number ${code}");
  }

  Future<bool?> checkVersion({required version}) async {
    bool isAllowed = false;
    try {
      Map payload = {
        "version": version
      };
      print("request ${payload}");
      var response = await http.post(
        Uri.parse(
            "http://112.196.54.37/Development/HW/wp-json/hwapi/version"),
        body: payload,
      );
      if (response.statusCode == 200) {
        data = VersionResponse.fromJson(json.decode(response.body));
        print("respojseo${data}");
        print("status Code ${response.statusCode}");
      } else {
        print("status Code ${response.statusCode}");
        // return false;
      }

      if (data == null) {
        print("[Common.CheckVersion] - Received Null");
        return false;
      }
      data.success == true ? isAllowed = true : false;
      if (!isAllowed) {
        print("API[${data.version}] == APP[$version]");
      }
      return isAllowed;
    } catch (e, st) {
      print("[Common.CheckVersion] - Error $e\n$st");
      return false;
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text("Partner Perks",),
            content: Container(
              height: 250,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const AppText("Humble Warrior", color: Colors.black, fontSize: 22),
                  AppText(
                    "${data.message ?? ""}",
                    // "We've just released a new update for the app which includes some great new features! To make sure you're getting the most out of the app, we recommend you update the app.",
                    color: Colors.black,
                    fontSize: 16,
                    maxLines: 6,
                    textAlign: TextAlign.center,
                    padding: EdgeInsets.only(top: 12, bottom: 16),
                  ),
                ],
              ),
            )

          // const Text("Please install the updated version from TestFlight"),
          // actions: <Widget>[
          //    IconButton(
          //     icon:  const Text("OK"),
          //     onPressed: () {
          //       // Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
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
          DialogHelper.showToast(context, incorrectPasswordTxt);
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
    await TokenManager(onTokenGenerate: () {}, onTokenEror: showError).init();
    Future.delayed(const Duration(seconds: 3), () {
      startTime();
      packageInfo();
    });

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
