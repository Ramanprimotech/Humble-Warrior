import 'package:get/get.dart';
import 'package:humble_warrior/view/my_account/my_account_controller.dart';

class MyAccountBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyAccountController());
  }
}
