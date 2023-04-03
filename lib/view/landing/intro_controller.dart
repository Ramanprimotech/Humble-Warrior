import 'package:humble_warrior/hw.dart';

class IntroScreenController extends GetxController {
  final pageController = PageController();

  RxInt currentIndex = 0.obs;

  void skipFunc() {
    pageController.jumpToBottom();
  }

  void startFunc() {
    Get.offNamed(AppRoutes.loginPage);
  }

  void nextFunc() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
