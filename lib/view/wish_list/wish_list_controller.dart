import 'package:get/get.dart';
import 'package:humble_warrior/utils/shared_prefrence/shared_pref.dart';
import '../../utils/app_strings.dart';

class WishListController extends GetxController{

  bool value = false;

  Future<void> getLoggedValue() async {
    value = await SharePreferenceData.getBoolValuesSF(isLogged) ?? false;
  }

}