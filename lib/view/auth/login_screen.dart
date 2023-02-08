import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:humble_warrior/view/auth/auth_widget.dart';
import 'package:humble_warrior/view/auth/login_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/app_colors.dart';
import '../../utils/image_path_assets.dart';
import '../../utils/localization/localization_String.dart';

class LoginScreen extends GetView<LoginController> with AuthWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child:  Image.asset(
                  ImagePathAssets.hw_logo,
                  height: 200,
                  width: 200,
                ),
              ).centered().pLTRB(0, 20, 0, 10),
              const SizedBox(
                height: 20
              ),

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

              /// Facebook
              optionWidget(
                  bckClr: AppColors.facebookClr,
                  title: LocalString.signWithFacebook,
                  textClr: AppColors.white,
                  imagePath: ImagePathAssets.facebookImg,
                  onTap: controller.onClickFunction(
                      action: OnClick.facebook, context: context)),

              /// Without Login
              optionWidget(
                  bckClr: AppColors.twitterClr,
                  imagePath: ImagePathAssets.twitterImg ,
                  title: "Continue Without Login",
                  textClr: AppColors.white,
                  onTap: (){
                    Get.offNamed(AppRoutes.bottomNavigation);
                  }),

              const Align(
                      alignment: Alignment.center,
                      child: AppText("Forgot Password ?"))
                  .px(40)
                  .py(20),
              Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppText("Sign up", fontSize: 24),
                    InkWell(
                        onTap:  (){
                          Get.offNamed(AppRoutes.bottomNavigation);
                        },
                        child: const AppText("Skip", fontSize: 24)),
                  ],
                ),
              ).px(20).py(30)
            ],
          ),
        ),
      ),
    );
  }
}
