import 'package:get/get.dart';
import 'package:humble_warrior/view/splash/splash_screen.dart';

class SplashBinding implements Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => SplashScreen());
  }
}