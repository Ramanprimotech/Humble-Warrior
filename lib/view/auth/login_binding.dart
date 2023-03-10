import 'package:get/get.dart';
import 'package:humble_warrior/view/auth/login_controller.dart';

class LoginBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}