import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:humble_warrior/utils/theme_extention/custom_notice_theme_extention.dart';
import 'package:humble_warrior/view/wish_list/wish_list_controller.dart';

class WishList extends StatelessWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WishListController controller = Get.find();
    final DialogueThemeExtention dialogueThemeExtention =
        Theme.of(context).extension<DialogueThemeExtention>()!;
    return Scaffold(
      body: Container(
        child: Center(
          child: controller.value == false
              ? Container(
                  height: 150,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: dialogueThemeExtention.backGroundColor,
                    boxShadow: [
                      BoxShadow(
                          color: dialogueThemeExtention.shadow!,
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 0))
                    ],
                  ),
                  child: Column(children: [
                     AppText(accessingMsgTxt,
                        color: dialogueThemeExtention.textColor,
                        fontSize: 20),
                    20.sh,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        // fixedSize: const Size(, 35),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: dialogueThemeExtention.buttonColor,
                      ),
                      onPressed: () {
                        Get.offAllNamed(AppRoutes.loginPage);
                      },
                      child: const AppText(gotoLoginTxt,
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ]),
                )
              : AppText(myFvrtTxt),
        ),
      ),
    );
  }
}
