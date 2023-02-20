import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_colors.dart';
import '../shared_prefrence/shared_pref.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  late SharedPreferences prefs;
  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;
  bool themeModeValue = true;
  Rx<Color> appBarColor = AppColors.white.obs;
  Rx<Color> headingColor = AppColors.black.obs;
  Rx<Color> dividerColor = AppColors.black.obs;
  Rx<Color> switchColor = AppColors.black.obs;
  Rx<Color> searchColor = AppColors.grey.obs;
  Rx<Color> searchHintColor = AppColors.grey.obs;
  Rx<Color> borderColor = AppColors.gray.obs;
  Rx<Color> topicBorderColor = AppColors.primary.obs;

  upgradeFun(bool value) {
    if (value) {
      /// dark mode
      appBarColor.value = AppColors.black;
      headingColor.value = AppColors.white;
      dividerColor.value = AppColors.white;
      switchColor.value = AppColors.primary;
      searchColor.value = AppColors.white;
      searchHintColor.value = AppColors.black;
      borderColor.value = AppColors.white;
      topicBorderColor.value = AppColors.white;

      debugPrint(" iff part --- ${appBarColor.value}");
    } else {
      /// light mode
      appBarColor.value = AppColors.white;
      headingColor.value = AppColors.black;
      dividerColor.value = AppColors.black;
      switchColor.value = AppColors.white;
      searchColor.value = Colors.grey.shade400.withOpacity(.5);
      searchHintColor.value = AppColors.white;
      borderColor.value = AppColors.gray;
      topicBorderColor.value = AppColors.primary;
      debugPrint(" else  part --- ${appBarColor.value}");
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    Get.changeThemeMode(themeMode);
    _themeMode = themeMode;
    update();
    await SharePreferenceData.addBoolToSF("mode", themeMode == ThemeMode.dark);
    // prefs = await SharedPreferences.getInstance();
    // await prefs.setString('theme', themeMode.toString().split('.')[1]);
  }

  // getThemeModeFromPreferences() async {
  //   ThemeMode themeMode;
  //   prefs = await SharedPreferences.getInstance();
  //   String themeText = prefs.getString('theme') ?? 'system';
  //   try {
  //     themeMode =
  //         ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
  //   } catch (e) {
  //     themeMode = ThemeMode.system;
  //   }
  //   setThemeMode(themeMode);
  // }
  getThemeModeFromPreferences() async {
    ThemeMode themeMode;
    bool? isDark =  await SharePreferenceData.getBoolValuesSF("mode");
    try {
      if(isDark == null){
        themeMode = ThemeMode.system;

      }else{
      themeMode =  isDark? ThemeMode.dark : ThemeMode.light;
      }

    } catch (e) {
      themeMode = ThemeMode.system;
    }
    setThemeMode(themeMode);
    return themeMode;
  }

  changeTheme(bool value,GetxController controller){
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
    upgradeFun(value);

    setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
    SharePreferenceData.addBoolToSF("mode", value);
    controller.update();
  }

  @override
  void onInit() {
    getThemeModeFromPreferences();
    super.onInit();
  }

}
