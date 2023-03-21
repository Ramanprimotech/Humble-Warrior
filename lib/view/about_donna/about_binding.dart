import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/view/static_pages/static_page_controller.dart';

class AboutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutScreenController());
    Get.lazyPut(() => StaticPagesController());
  }
}
