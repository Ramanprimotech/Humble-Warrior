import 'dart:io';

import 'package:humble_warrior/hw.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential).then((value){
      Get.offAllNamed(AppRoutes.bottomNavigation);
      print('testing------${value.user!.displayName}');
      return value;
    }
    );
  }

  ///---------------------Click Login Button Functionality-----------------------///
  Function onClickFunction(
      {required OnClick action, required BuildContext context}) {
    Map<OnClick, void Function()> actions = {
      ///--------Click  facebook
      OnClick.facebook: () async {
          // Trigger the sign-in flow
          // signInWithFacebook();
        try {
          Loader.show(context);

          user = await AuthManager().facebookLogin();
          if (user != null) {
            /// Save User Info to Local Storage
            await saveUserToLocalStorage(fb:true);

            await authAPI().whenComplete(
                    () {
                  Get.offAllNamed(AppRoutes.bottomNavigation);
                });
          }
        } catch (e) {
          print(e);
        }finally{
          Loader.hide();
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
            /// Save User Info to Local Storage
            await saveUserToLocalStorage();

            /// Auth Data API
            await authAPI().whenComplete(
                () {
                  Get.offAllNamed(AppRoutes.bottomNavigation);
                });
          }
        } catch (e, st) {
          print(e);
        }finally{
          Loader.hide();
        }
      },

      /// ----------- Click apple
      OnClick.apple: () async {
        try{
          Loader.show(context);
        user = await AuthManager().appleLogin();
        if (user != null) {
          await saveUserToLocalStorage();

          /// Auth Data API
          await authAPI().whenComplete(
                  () {
                Get.offAllNamed(AppRoutes.bottomNavigation);
              });
        }
      }finally{
          Loader.hide();
        }
    },

      /// Click Continue without login
      OnClick.continueWithoutLogin: () async {
        /// Save User Info to Local Storage
        await SharePreferenceData.addBoolToSF(spIsEntered, true);

        /// Auth Data API
        Get.offAllNamed(AppRoutes.bottomNavigation);
      }
    };
    Function act = actions[action]!;
    return act;
  }

  ///-----------------------Save User Info to Local Storage--------------------------///
  Future<void> saveUserToLocalStorage({ bool fb = false}) async {
    isLoggedIn = true;
    await SharePreferenceData.addBoolToSF(spIsLogged, true);
    await SharePreferenceData.addStringToSF(userId, user!.uid);
    await SharePreferenceData.addStringToSF(userEmail, "${user?.providerData[0].email}");
    await SharePreferenceData.addStringToSF(
        userPhoneNumber, "${user?.providerData[0].phoneNumber}");
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
    await CallAPI.authDataAPI(payload: payload);
  }
}

enum OnClick { facebook, google, apple, continueWithoutLogin }
