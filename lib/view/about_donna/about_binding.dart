import 'package:humble_warrior/hw.dart';

class AboutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutScreenController());
  }
}
