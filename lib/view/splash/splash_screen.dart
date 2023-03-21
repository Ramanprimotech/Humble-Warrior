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
          () => TweenAnimationBuilder(
            builder: (BuildContext context, double? value, Widget? child) {
              return Transform.scale(scale: value,child: child);

            },
            tween: Tween(begin: .2, end: 1.5),
            duration: const Duration(seconds: 2),
            child: Image.asset(
              controller.isDark.value
                  //     ? ImagePathAssets.logoAnimation
                  //     : ImagePathAssets.logoAnimation,
                  ? ImagePathAssets.hwLogoDarkMode
                  : ImagePathAssets.hwLogo,
              height: 200,
              width: 200,
            ),
          ),
        ),
      ),
    );
  }
}
