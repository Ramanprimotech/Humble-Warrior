import 'package:get/get.dart';
import 'package:humble_warrior/view/splash/spalsh_controller.dart';

class SplashBinding implements Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => SplashController());
  }
}