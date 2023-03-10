import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/requests/auth_data_request.dart';
import 'package:humble_warrior/network/api_call.dart';

class LoginController extends GetxController {
  User? user;
  RxBool isPlatformIOS = false.obs;

  checkCurrentPlatform() {
    if (Platform.isAndroid) {
      isPlatformIOS.value = false;
      debugPrint("platform -- if --- ${isPlatformIOS.value}");
    } else if (Platform.isIOS) {
      isPlatformIOS.value = true;
      debugPrint("platform -- else --- ${isPlatformIOS.value}");
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
    /// Platform
    String platform = Platform.isAndroid ? "Android" : "iOS";

    Map<OnClick, void Function()> actions = {
      /// Click  facebook
      OnClick.facebook: () async {
        debugPrint("bbhbhnbnjnjnj");

        /// User Firebase Token
        String? tokenFirebase = await FirebaseMessaging.instance.getToken();

        try {
          user = await AuthManager().facebookLogin();
          if (user != null) {
            Get.snackbar("Login ", "User Login Successfully ");
            await SharePreferenceData.addBoolToSF(spIsLogged, true);
            await SharePreferenceData.addStringToSF(
                userEmail, "${user?.email}");
            await SharePreferenceData.addStringToSF(
                userPhoneNumber, "${user!.phoneNumber}");

            await SharePreferenceData.addStringToSF(
                userName, "${user?.displayName}");
            await SharePreferenceData.addStringToSF(
                userProfilePic, "${user?.photoURL}");
            await SharePreferenceData.addBoolToSF(spIsEntered, true);
            Get.toNamed(AppRoutes.bottomNavigation);

            /// Auth Data API
            await authAPI(platform, tokenFirebase);
          }
        } catch (e) {
          debugPrint("error --- $e");
        }
      },

      /// Click Google
      OnClick.google: () async {
        try {
          Loader.show(context);

          /// User Firebase Token
          String? tokenFirebase = await FirebaseMessaging.instance.getToken();

          user = await AuthManager().googleLogin(
              androidClientId:
                  DefaultFirebaseOptions.currentPlatform.androidClientId ?? "",
              iosClientId:
                  DefaultFirebaseOptions.currentPlatform.iosClientId ?? "");

          if (user != null) {
            Loader.hide();
            Get.snackbar("Login ", "User Login Successfully ");
            await SharePreferenceData.addBoolToSF(spIsLogged, true);
            await SharePreferenceData.addStringToSF(
                userEmail, "${user?.email}");
            await SharePreferenceData.addStringToSF(
                userPhoneNumber, "${user?.phoneNumber}");
            print("User phone number ${user?.phoneNumber}");
            await SharePreferenceData.addStringToSF(
                userName, "${user?.displayName}");
            await SharePreferenceData.addStringToSF(
                userProfilePic, "${user?.photoURL}");
            await SharePreferenceData.addBoolToSF(spIsEntered, true);

            Get.offNamed(AppRoutes.bottomNavigation);
            "${user!.uid.toString()}".log();

            /// Auth Data API
            await authAPI(platform, tokenFirebase);
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

        /// User Firebase Token
        String? tokenFirebase = await FirebaseMessaging.instance.getToken();

        user = await AuthManager().appleLogin();
        if (user != null) {
          Get.snackbar("Login ", "User Login Successfully ");
          await SharePreferenceData.addBoolToSF(spIsLogged, true);
          await SharePreferenceData.addStringToSF(userEmail, "${user?.email}");
          await SharePreferenceData.addStringToSF(
              userPhoneNumber, "${user?.phoneNumber}");
          await SharePreferenceData.addStringToSF(
              userName, "${user?.displayName}");
          await SharePreferenceData.addStringToSF(
              userProfilePic, "${user?.photoURL}");
          await SharePreferenceData.addBoolToSF(spIsEntered, true);
          if (userPhoneNumber.isEmpty || userProfilePic.isEmpty) {
            Get.toNamed(AppRoutes.bottomNavigation);
          }
          Get.toNamed(AppRoutes.bottomNavigation);

          /// Auth Data API
          await authAPI(platform, tokenFirebase);
        }
      },

      /// Click Continue without login
      OnClick.continueWithoutLogin: () async {
        await SharePreferenceData.addBoolToSF(spIsEntered, true);
        Get.offNamed(AppRoutes.bottomNavigation);
      }
    };

    Function act = actions[action]!;

    return act;
  }

  Future<void> authAPI(String platform, String? tokenFirebase) async {
    AuthDataRequest payload =
        AuthDataRequest(userId: user!.uid, os: platform, token: tokenFirebase);
    await CallAPI.authDataAPI(payload: payload);
  }
}

enum OnClick { facebook, google, apple, continueWithoutLogin }
