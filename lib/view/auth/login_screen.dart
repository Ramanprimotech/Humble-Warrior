import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/view/auth/auth_widget.dart';
import 'package:humble_warrior/view/auth/login_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/app_colors.dart';
import '../../utils/image_path_assets.dart';
import '../../utils/image_path_network.dart';
import '../../utils/localization/localization_String.dart';

class LoginScreen extends GetView<LoginController> with AuthWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                height: 200,
                width: 200,
                fit: BoxFit.cover,
                imageUrl: ImagePathNetwork.url,
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ).centered().pLTRB(0, 20, 0, 10),
            SizedBox(
              height: Get.height *.14,
            ),
            /// Facebook
            optionWidget(bckClr: AppColors.facebookClr,title:LocalString.signWithFacebook,textClr: AppColors.white,imagePath: ImagePathAssets.facebookImg, onTap: controller.onClickFunction(action: OnClick.facebook,context: context)),

            /// Google
            optionWidget(bckClr: AppColors.white,title:LocalString.signWithGoogle,textClr: AppColors.black,imagePath: ImagePathAssets.googleImg,onTap: controller.onClickFunction(action: OnClick.google, context: context)),

            /// Apple

           optionWidget(bckClr: AppColors.grey,title:LocalString.signWithApple,textClr: AppColors.white,imagePath: ImagePathAssets.appleImg,onTap: controller.onClickFunction(action: OnClick.apple,context: context)),



          ],
        ),
      ),


    );
  }
}