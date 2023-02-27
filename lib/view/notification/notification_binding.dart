import 'package:get/get.dart';
import 'package:humble_warrior/view/notification/notification_controller.dart';

class NotificationBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
  }
}