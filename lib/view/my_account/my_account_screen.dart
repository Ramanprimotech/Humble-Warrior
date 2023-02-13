import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/utils/helpers/dialog_helper.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:humble_warrior/view/my_account/my_account_controller.dart';
import 'package:humble_warrior/view/my_account/my_account_widget.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyAccountController controller = Get.find();

    MyAccWidget myAccWidget = MyAccWidget(context: context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Obx(
            () => Column(children: [
              if (controller.userCheck.value == true) ...[
                myAccWidget.profileImage(),
                10.sh,
                myAccWidget.divider(),
              ],
              10.sh,
              myAccWidget.myAccountTextFun(heading: myAccountTxt),
              myAccWidget.detailsOptions(controller, title: accountDetailsTxt),
              myAccWidget.detailsOptions(controller,
                  title: notificationsTxt,
                  isSwitchRequired: true,
                  click: controller.switchFunc),
              10.sh,
              myAccWidget.divider(),
              10.sh,
              myAccWidget.myAccountTextFun(heading: theHumbleWarriorTxt),
              myAccWidget.detailsOptions(controller, title: aboutDonna,
                  ontap: () {
                Get.toNamed(AppRoutes.aboutDonna);
              }),
              myAccWidget.detailsOptions(controller,
                  title: shareWithFriendsTxt),
              10.sh,
              myAccWidget.divider(),
              10.sh,
              myAccWidget.myAccountTextFun(heading: settingsTxt),
              myAccWidget.detailsOptions(controller, title: passcodeTxt),
              myAccWidget.detailsOptions(controller,
                  title: darkModeTxt,
                  isSwitchRequired: true,
                  click: controller.darkMode),
              myAccWidget.detailsOptions(controller, title: helpSupportTxt),
              myAccWidget.detailsOptions(controller, title: termsConditionsTxt),
              controller.userCheck.value == true
                  ? myAccWidget.detailsOptions(controller, title: logoutTxt,
                      ontap: () {
                      DialogHelper.logoutDialog(
                          context: context, onTap: controller.logout);
                    })
                  : myAccWidget.detailsOptions(controller, title: login,
                      ontap: () {
                      DialogHelper.logoutDialog(
                          context: context, onTap: controller.loginPage());
                    }),
              const AppText('$appVersionTxt V 1.0'),
              10.sh,
            ]),
          ),
        ),
      ),
    );
  }
}
