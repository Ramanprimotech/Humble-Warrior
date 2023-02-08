
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:humble_warrior/utils/shared_prefrence/shared_pref.dart';
import 'package:humble_warrior/view/my_account/my_account_controller.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyAccountController controller = Get.put(MyAccountController());
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
      child: SingleChildScrollView(
        child: Column(children: [
          _profileImage(),
          10.sh,
          _divider(),
          10.sh,
          _myAccountTxt(heading: "MY ACCOUNT"),
          _detailsOptions(controller, title: "Account Details"),
          _detailsOptions(controller,
              title: "Notifications",
              isSwitchRequired: true,
              click: controller.switchFunc),
          10.sh,
          _divider(),
          10.sh,
          _myAccountTxt(heading: "THE HUMBLE WARRIOR"),
          _detailsOptions(controller, title: "About Donna", ontap: () {
            Get.toNamed(AppRoutes.aboutDonna);
          }),
          _detailsOptions(controller, title: "Share with friends"),
          10.sh,
          _divider(),
          10.sh,
          _myAccountTxt(heading: "SETTINGS"),
          _detailsOptions(controller, title: "Passcode"),
          _detailsOptions(controller,
              title: "Dark Mode",
              isSwitchRequired: true,
              click: controller.darkMode),
          _detailsOptions(controller, title: "Help & Support"),
          _detailsOptions(controller, title: "Terms & Conditions"),
          GestureDetector(
            onTap: () async {
              SharePreferenceData.clear();
              FirebaseAuth.instance.signOut();

              Get.offNamed(AppRoutes.introScreen);

            },
            child:  _detailsOptions(controller, title: "Logout"),
          ),

          AppText('APP VERSION V 1.0'),
          10.sh,
        ]),
      ),
    );
  }

  _profileImage() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade200,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt, color: Colors.black, size: 40),
              5.sh,
              AppText("Add Photo"),
            ],
          ),
        ),
        10.sh,
        AppText("Peter Wilson"),
        AppText("Peter.Wilson@gmail.com"),
      ],
    );
  }

  _divider() {
    return Divider(
      color: Colors.grey.shade200,
      height: 2,
    );
  }

  _myAccountTxt({heading}) {
    return Align(
      alignment: Alignment.topLeft,
      child: AppText(heading, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  _detailsOptions(MyAccountController controller,
      {title, bool isSwitchRequired = false, ontap, click}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.only(
            left: 15,
            right: 5,
            top: isSwitchRequired ? 0 : 10,
            bottom: isSwitchRequired ? 0 : 10),
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 7),
        width: MediaQuery.of(Get.context!).size.width,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade600,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 3),
              )
            ]),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          AppText(
            title,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade900,
          ),
          isSwitchRequired
              ? Obx(
                  () => Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                        (Set<MaterialState> states) {
                          // Thumb icon when the switch is selected.
                          if (states.contains(MaterialState.selected)) {
                            return const Icon(Icons.check);
                          }
                          return const Icon(Icons.close);
                        },
                      ),
                      value: title == "Notifications"
                          ? controller.checkNotification.value
                          : controller.checkDark.value,
                      activeColor: Colors.green,
                      inactiveTrackColor: Colors.red,
                      thumbColor: MaterialStateProperty.all(Colors.white),
                      onChanged: (_) {
                        click();
                        //controller.update();
                      },
                    ),
                  ),
                )
              : const SizedBox(),
        ]),
      ),
    );
  }
}
