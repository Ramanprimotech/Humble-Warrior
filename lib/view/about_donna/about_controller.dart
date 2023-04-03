import 'package:humble_warrior/hw.dart';

class AboutScreenController extends GetxController {
  RxBool readMore = true.obs;

  void readStatus() {
    readMore.value = !readMore.value;
  }

  RxBool isOpen = true.obs;

  viewFunc() {
    isOpen.value = !isOpen.value;
  }
}
