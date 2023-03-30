import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/network/api_call.dart';

class LoginController extends GetxController {
  User? user;
  RxBool isPlatformIOS = false.obs;
  String? platform;

  ///----------Check Current Platform----------///
  checkCurrentPlatform() {
    if (Platform.isAndroid) {
      isPlatformIOS.value = false;
      platform = "Android";
    } else if (Platform.isIOS) {
      isPlatformIOS.value = true;
      platform = "iOS";
    }
  }

  @override
  void onInit() {
    checkCurrentPlatform();
    super.onInit();
  }

  ///---------------------Click Login Button Functionality-----------------------///
  Function onClickFunction(
      {required OnClick action, required BuildContext context}) {
    Map<OnClick, void Function()> actions = {
      ///--------Click  facebook
      OnClick.facebook: () async {
        try {
          user = await AuthManager().facebookLogin();
          if (user != null) {
            /// Save User Info to Local Storage
            await saveUserToLocalStorage();

            Get.offAllNamed(AppRoutes.bottomNavigation);

            /// Auth Data API
            await authAPI();
          }
        } catch (e) {
          debugPrint("error --- $e");
        }
      },

      ///------------ Click Google
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

            /// Save User Info to Local Storage
            await saveUserToLocalStorage();

            Get.offAllNamed(AppRoutes.bottomNavigation);

            /// Auth Data API
            await authAPI();
          } else {
            Loader.hide();
          }
        } catch (e) {
          Loader.hide();
          // Get.snackbar("Error ", "$e ");
        }
      },

      /// ----------- Click apple
      OnClick.apple: () async {
        user = await AuthManager().appleLogin();
        if (user != null) {
          await saveUserToLocalStorage();
          if (userPhoneNumber.isEmpty || userProfilePic.isEmpty) {
            Get.offAllNamed(AppRoutes.bottomNavigation);
          }
          Get.offAllNamed(AppRoutes.bottomNavigation);

          /// Auth Data API
          await authAPI();
        }
      },

      /// Click Continue without login
      OnClick.continueWithoutLogin: () async {
        /// Save User Info to Local Storage
        await SharePreferenceData.addBoolToSF(spIsEntered, true);

        /// Auth Data API
        await authAPI()
            .whenComplete(() => Get.offAllNamed(AppRoutes.bottomNavigation));
      }
    };
    Function act = actions[action]!;
    return act;
  }

  ///-----------------------Save User Info to Local Storage--------------------------///
  Future<void> saveUserToLocalStorage() async {
    await SharePreferenceData.addBoolToSF(spIsLogged, true);
    await SharePreferenceData.addStringToSF(userEmail, "${user?.email}");
    await SharePreferenceData.addStringToSF(
        userPhoneNumber, "${user?.phoneNumber}");
    await SharePreferenceData.addStringToSF(userName, "${user?.displayName}");
    await SharePreferenceData.addStringToSF(
        userProfilePic, "${user?.photoURL}");
    await SharePreferenceData.addBoolToSF(spIsEntered, true);
  }

  ///---------------Send User info to server and get notification user_id------------------///
  Future<void> authAPI() async {
    /// User Firebase Token
    String? tokenFirebase = await FirebaseMessaging.instance.getToken();

    var payload = {
      "token": tokenFirebase,
      "device": platform ?? "Android",
      "user_id": user == null ? "" : user!.uid,
      "email": user == null ? "" : user!.email ?? ""
    };
    print("Apple-------------$payload");
    await CallAPI.authDataAPI(payload: payload);
  }
}

enum OnClick { facebook, google, apple, continueWithoutLogin }
