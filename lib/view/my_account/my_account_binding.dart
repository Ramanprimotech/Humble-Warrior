import 'package:humble_warrior/hw.dart';

class MyAccountBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyAccountController());
  }
}
