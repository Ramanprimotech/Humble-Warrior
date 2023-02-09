import 'package:get/get.dart';
import 'package:humble_warrior/utils/shared_prefrence/shared_pref.dart';

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
  void onInit() {
    Future.delayed(const Duration(seconds: 5), () {
      getData();
    });
    super.onInit();
  }
}
