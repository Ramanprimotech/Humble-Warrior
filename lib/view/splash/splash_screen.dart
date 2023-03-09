import 'package:humble_warrior/hw.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController controller = Get.find();
    controller.context = context;
    return Scaffold(
      body: Center(
        child: Obx(
          () => Image.asset(
            controller.isDark.value
                ? ImagePathAssets.hwLogoDarkMode
                : ImagePathAssets.hwLogo,
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}
