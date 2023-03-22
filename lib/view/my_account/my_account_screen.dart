import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/common/common_functionality.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/utils/helpers/dialog_helper.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:humble_warrior/view/my_account/my_account_controller.dart';
import 'package:humble_warrior/view/my_account/my_account_widget.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FToast().init(context);
    MyAccountController controller = Get.find();
    controller.context = context;
    MyAccWidget myAccWidget = MyAccWidget(context: context);
    double optionSpacing = 15;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Obx(
              () => Column(children: [
                ///Image and account details
                if (controller.userCheck.value == true) ...[
                  myAccWidget.profileImage(),
                  optionSpacing.sh,
                  myAccWidget.divider(),
                ],
                optionSpacing.sh,

                ///===> My Account
                myAccWidget.myAccountTextFun(heading: myAccountTxt),

                ///Account Details
                myAccWidget.detailsOptions(controller, title: accountDetailsTxt,
                    ontap: () {
                  Get.toNamed(AppRoutes.accountDetails);
                }),

                ///Notification
                myAccWidget.detailsOptions(controller,
                    title: notificationsTxt,
                    isSwitchRequired: true,
                    click: controller.switchFunc),
                optionSpacing.sh,
                // myAccWidget.divider(),
                // optionSpacing.sh,

                ///=====>The Humble Warrior
                myAccWidget.myAccountTextFun(heading: theHumbleWarriorTxt),

                ///About Donna
                myAccWidget.detailsOptions(controller, title: aboutDonna,
                    ontap: () {
                  Get.toNamed(AppRoutes.aboutDonna);
                }),

                ///Share with friends
                myAccWidget.detailsOptions(
                  controller,
                  title: shareWithFriendsTxt,
                  ontap: () async {
                    CommonUtils().share(shareUrl: "https://humblewarrior.com/");
                  },
                ),
                // // optionSpacing.sh,
                // myAccWidget.divider(),
                optionSpacing.sh,

                ///====>Settings
                myAccWidget.myAccountTextFun(heading: settingsTxt),

                ///Passcode
                myAccWidget.detailsOptions(controller, title: passcodeTxt,
                    ontap: () {
                  controller.tapPasscode();
                }),

                ///Dark Mode
                myAccWidget.detailsOptions(controller,
                    title: darkModeTxt,
                    isSwitchRequired: true,
                    click: controller.darkMode),

                ///Help & Support
                myAccWidget.detailsOptions(controller, title: helpSupportTxt,
                    ontap: () {
                  Get.toNamed(AppRoutes.staticPages,
                      arguments: ["40429", "Help & Support"]);
                }),

                ///Term & Conditions
                myAccWidget.detailsOptions(controller,
                    title: termsConditionsTxt, ontap: () {
                  Get.toNamed(AppRoutes.staticPages,
                      arguments: ["40427", "Term & Conditions"]);
                }),

                ///Login or Logout
                _loginOrLogout(context),
                10.sh,
              ]),
            ),
          ),
        ),
      ),
    );
  }

  /// Login Or Logout
  Widget _loginOrLogout(context) {
    MyAccountController controller = Get.find();
    MyAccWidget myAccWidget = MyAccWidget(context: context);
    return controller.userCheck.value == true
        ? myAccWidget.detailsOptions(controller, title: logoutTxt, ontap: () {
            DialogHelper.logoutDialog(
                context: context, onTap: controller.logout);
          })
        : myAccWidget.detailsOptions(controller, title: login, ontap: () {
            DialogHelper.logoutDialog(
                context: context, onTap: controller.loginPage());
          });
  }
}
