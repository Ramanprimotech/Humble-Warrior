import 'dart:developer';

import 'package:get/get.dart';
import 'package:humble_warrior/network/api_call.dart';
import 'package:humble_warrior/utils/shared_prefrence/shared_pref.dart';

import '../../modals/requests/token_model_request.dart';
import '../../network/endpoints.dart';
import '../../utils/app_strings.dart';
import '../../utils/routes/app_routes.dart';

class SplashController extends GetxController {
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
    Future.delayed(const Duration(seconds: 5), () {
      getData();
    });
    await generateToken();
    super.onInit();
  }

  Future generateToken() async {
    TokenRequestModel tokenRequestModel = TokenRequestModel(userid: "4"

        // username: "info@newjerseymultimedia.com",
        // password: "JtB@zCajal87@7MVXjzfyxOd"
        );
    await CallAPI.generateToken(payload: tokenRequestModel).then((value) {
      Endpoints.token = value.token.toString();
      log(value.token.toString());
    });
  }
}
