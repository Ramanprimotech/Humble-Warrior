import 'dart:io';

import 'package:humble_warrior/hw.dart';

class LoginScreen extends GetView<LoginController> with AuthWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              100.shb,
              ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.asset(
                  themeController.themeMode == ThemeMode.dark
                      ? ImagePathAssets.hwLogoDarkMode
                      : ImagePathAssets.hwLogo,
                  width: Get.width * .65,
                ),
              ).centered().pLTRB(0, 20, 0, 10),
              40.shb,
              SizedBox(
                height: 80 * 4,
                child: Column(
                  children: [
                    20.shb,

                    /// Facebook
                    optionWidget(
                        bckClr: AppColors.facebookClr,
                        title: signWithFacebook,
                        textClr: AppColors.white,
                        imagePath: ImagePathAssets.facebookImg,
                        onTap: controller.onClickFunction(
                            action: OnClick.facebook, context: context)),

                    /// Google
                    optionWidget(
                        bckClr: AppColors.white,
                        title: signWithGoogle,
                        textClr: AppColors.black,
                        imagePath: ImagePathAssets.googleImg,
                        onTap: controller.onClickFunction(
                            action: OnClick.google, context: context)),

                    /// Apple
                    if (Platform.isIOS)
                      optionWidget(
                          bckClr: AppColors.grey,
                          title: signWithApple,
                          textClr: AppColors.white,
                          imagePath: ImagePathAssets.appleImg,
                          onTap: controller.onClickFunction(
                              action: OnClick.apple, context: context)),

                    /// Without Login
                    optionWidget(
                        bckClr: AppColors.twitterClr,
                        title: signWithoutLogin,
                        textClr: AppColors.white,
                        onTap: controller.onClickFunction(
                            action: OnClick.continueWithoutLogin,
                            context: context)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
