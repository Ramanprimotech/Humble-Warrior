import 'package:get/get.dart';
import 'package:humble_warrior/view/my_account/account_details/account_details_controller.dart';

class AccountDetailsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountDetailsController());
  }
}