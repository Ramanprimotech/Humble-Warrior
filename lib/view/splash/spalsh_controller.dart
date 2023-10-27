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
    var duration = const Duration(milliseconds: 800);
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

            DialogHelper.closeDialog();
        }


/*  Future<void> getData() async {
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
            data.message != "" ? _showDialog(context) : DialogHelper.showMaintenanceDialog(context);
          }
          DialogHelper.closeDialog();
        });
      }
    );
  }*/

  packageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = "1.0.4";
    // version = packageInfo.version;
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
        Uri.parse("${Endpoints.baseUrl}${Endpoints.version}"),
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
        final AccountOptionTheme accountOptionTheme =
        Theme.of(Get.context!).extension<AccountOptionTheme>()!;
        return AlertDialog(
          elevation: 3,
          shadowColor: Theme.of(context).extension<ShadowTheme>()!.shadowColor!,
          backgroundColor: accountOptionTheme.backGroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
            content: Container(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppText("Humble Warrior", color: accountOptionTheme.textColor, fontSize: 22),
                  AppText(
                    data.message ?? "Application is under Maintenance.",
                    // "We've just released a new update for the app which includes some great new features! To make sure you're getting the most out of the app, we recommend you update the app.",
                    color: accountOptionTheme.textColor,
                    fontSize: 16,
                    maxLines: 6,
                    textAlign: TextAlign.center,
                    padding: 16.pv,
                  ),
                  20.shb,
                  data.message != "" ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      // fixedSize: const Size(, 35),
                      padding: 15.ph,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Theme.of(context).extension<DialogueThemeExtention>()!.buttonColor,
                    ),
                    onPressed: (){
                      CommonUtils().urlLauncher(url: Platform.isAndroid
                          ? data.androidLink!.isNotEmpty ? data.androidLink! : ""
                          : Platform.isIOS
                          ? data.iosLink!.isNotEmpty ? data.iosLink! : ""
                          : data.iosLink!.isNotEmpty ? data.iosLink! : "");
                    },
                    child: const AppText("Update",
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ) : SizedBox(),
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
    packageInfo();
    await TokenManager(onTokenGenerate: () {}, onTokenEror: showError).init();

    Future.delayed(const Duration(seconds: 3), () async {
      await CommonUtils.toCheckInternet(
          context: context,
          action: () async {
            await checkVersion(version: version).then((value) async {
              canNavigateInside = true;
              if(value == true){
                startTime();
              }
              else {
                DialogHelper.closeDialog();
                data.message != "" ? _showDialog(context) : DialogHelper.showMaintenanceDialog(context);
              }
              DialogHelper.closeDialog();
            });
          }
      );
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
