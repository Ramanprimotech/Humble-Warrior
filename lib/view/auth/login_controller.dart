import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/network/api_call.dart';

class LoginController extends GetxController {
  User? user;
  RxBool isPlatformIOS = false.obs;
  String? platform;

  checkCurrentPlatform() {
    if (Platform.isAndroid) {
      isPlatformIOS.value = false;
      platform = "Android";
      debugPrint("platform -- if --- ${isPlatformIOS.value}");
    } else if (Platform.isIOS) {
      isPlatformIOS.value = true;
      platform = "iOS";
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
    Map<OnClick, void Function()> actions = {
      /// Click  facebook
      OnClick.facebook: () async {
        debugPrint("bbhbhnbnjnjnj");

        /// User Firebase Token
        String? tokenFirebase = await FirebaseMessaging.instance.getToken();

        try {
          user = await AuthManager().facebookLogin();
          if (user != null) {
            // Get.snackbar("Login ", "User Login Successfully ");
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
            Get.offAllNamed(AppRoutes.bottomNavigation);

            /// Auth Data API
            await authAPI();
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
            // DialogHelper.showToast(context, "User Login Successfully");
            // Get.snackbar("Login ", "User Login Successfully ");
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

            Get.offAllNamed(AppRoutes.bottomNavigation);
            "${user!.uid.toString()}".log();

            /// Auth Data API
            await authAPI();
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
          // Get.snackbar("Login ", "User Login Successfully ");
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
            Get.offAllNamed(AppRoutes.bottomNavigation);
          }
          Get.offAllNamed(AppRoutes.bottomNavigation);

          /// Auth Data API
          await authAPI();
        }
      },

      /// Click Continue without login
      OnClick.continueWithoutLogin: () async {
        await SharePreferenceData.addBoolToSF(spIsEntered, true);

        /// Auth Data API
        await authAPI();

        Get.offAllNamed(AppRoutes.bottomNavigation);
      }
    };

    Function act = actions[action]!;

    return act;
  }

  Future<void> authAPI() async {
    /// User Firebase Token
    String? tokenFirebase = await FirebaseMessaging.instance.getToken();

    var payload = {
      "token": tokenFirebase,
      "device": platform ?? "Android",
      "user_id": user == null ? "" : user!.uid,
      "email": user == null ? "" : user!.email ?? ""
    };
    // AuthDataRequest payload = AuthDataRequest(
    //     token: tokenFirebase,
    //     device: platform,
    //     userId: user == null ? "" : user!.uid,
    //     email: user == null ? "" : user!.email ?? "");
    await CallAPI.authDataAPI(payload: payload);
  }
}

enum OnClick { facebook, google, apple, continueWithoutLogin }
