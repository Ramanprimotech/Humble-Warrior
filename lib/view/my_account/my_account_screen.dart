
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/utils/helpers/dialog_helper.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:humble_warrior/view/my_account/my_account_controller.dart';
import 'package:humble_warrior/view/my_account/my_account_widget.dart';



class MyAccount extends StatelessWidget  {
     const MyAccount({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    MyAccountController controller = Get.find();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Obx(()=>
             Column(children: [
              if(controller.userCheck.value == true)...[
                MyAccWidget().profileImage(),
              10.sh,
                MyAccWidget(). divider(),
              ],
              10.sh,
               MyAccWidget(). myAccountTextFun(heading: myAccountTxt),
               MyAccWidget().detailsOptions(controller, title: accountDetailsTxt),
               MyAccWidget().detailsOptions(controller,
                  title: notificationsTxt,
                  isSwitchRequired: true,
                  click: controller.switchFunc),
              10.sh,
               MyAccWidget().divider(),
              10.sh,
               MyAccWidget(). myAccountTextFun(heading: theHumbleWarriorTxt),
               MyAccWidget(). detailsOptions(controller, title: aboutDonna, ontap: () {
                Get.toNamed(AppRoutes.aboutDonna);
              }),
               MyAccWidget(). detailsOptions(controller, title: shareWithFriendsTxt),
              10.sh,
               MyAccWidget().  divider(),
              10.sh,
               MyAccWidget().   myAccountTextFun(heading: settingsTxt),
               MyAccWidget(). detailsOptions(controller, title: passcodeTxt),
               MyAccWidget(). detailsOptions(controller,
                  title: darkModeTxt,
                  isSwitchRequired: true,
                  click: controller.darkMode),
               MyAccWidget(). detailsOptions(controller, title: helpSupportTxt),
               MyAccWidget().detailsOptions(controller, title: termsConditionsTxt),

               controller.userCheck.value == true?
               MyAccWidget(). detailsOptions(controller, title: logoutTxt,ontap: (){
                DialogHelper.logoutDialog(context: context, onTap:controller.logout);
              }):MyAccWidget().detailsOptions(controller, title: login,ontap: (){
                 DialogHelper.logoutDialog(context: context, onTap:controller.loginPage());
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
