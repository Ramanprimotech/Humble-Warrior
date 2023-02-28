import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_themes/app_theme_controller.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:humble_warrior/utils/theme_extention/account_option_theme_extentions.dart';
import 'package:humble_warrior/view/auth/auth_widget.dart';
import 'package:humble_warrior/view/auth/login_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/app_colors.dart';
import '../../utils/image_path_assets.dart';
import '../../utils/localization/localization_string.dart';

class LoginScreen extends GetView<LoginController> with AuthWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
   ThemeController themeController = Get.find();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              100.sh,
              ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.asset(
                themeController.themeMode==ThemeMode.dark ?  ImagePathAssets.hwLogoDarkMode : ImagePathAssets.hwLogo,
                  width: Get.width * .65,
                ),
              ).centered().pLTRB(0, 20, 0, 10),
             40.sh,
              SizedBox(
                height: 80 * 4,
                child: Column(
                  children: [
                    20.sh,

                    /// Facebook
                    optionWidget(
                        bckClr: AppColors.facebookClr,
                        title: LocalString.signWithFacebook,
                        textClr: AppColors.white,
                        imagePath: ImagePathAssets.facebookImg,
                        onTap: controller.onClickFunction(
                            action: OnClick.facebook, context: context)),

                    /// Google
                    optionWidget(
                        bckClr: AppColors.white,
                        title: LocalString.signWithGoogle,
                        textClr: AppColors.black,
                        imagePath: ImagePathAssets.googleImg,
                        onTap: controller.onClickFunction(
                            action: OnClick.google, context: context)),

                    /// Apple
                    optionWidget(
                        bckClr: AppColors.grey,
                        title: LocalString.signWithApple,
                        textClr: AppColors.white,
                        imagePath: ImagePathAssets.appleImg,
                        onTap: controller.onClickFunction(
                            action: OnClick.apple, context: context)),

                    /// Without Login
                    optionWidget(
                        bckClr: AppColors.twitterClr,
                        title: LocalString.signWithoutLogin,
                        textClr: AppColors.white,
                        onTap: () {
                          Get.offNamed(AppRoutes.bottomNavigation);
                        }),
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
