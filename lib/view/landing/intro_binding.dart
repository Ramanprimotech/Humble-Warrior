import 'package:get/get.dart';
import 'package:humble_warrior/view/landing/intro_controller.dart';

class IntroBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => IntroScreenController());
  }

}