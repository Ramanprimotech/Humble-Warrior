import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/common/common_functionality.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/utils/helpers/dialog_helper.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:humble_warrior/utils/sizes/enums.dart';
import 'package:humble_warrior/view/my_account/my_account_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/button.dart';

class MyAccount extends StatelessWidget {
   MyAccount({Key? key}) : super(key: key);
  final MyAccountController controller = Get.put(MyAccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Column(children: [
            _profileImage(controller),
            10.sh,
            _divider(),
            10.sh,
            _myAccountTxt(heading: myAccountTxt),
            _detailsOptions(controller, title: accountDetailsTxt),
            _detailsOptions(controller,
                title: notificationsTxt,
                isSwitchRequired: true,
                click: controller.switchFunc),
            10.sh,
            _divider(),
            10.sh,
            _myAccountTxt(heading: theHumbleWarriorTxt),
            _detailsOptions(controller, title: aboutDonna, ontap: () {
              Get.toNamed(AppRoutes.aboutDonna);
            }),
            _detailsOptions(controller, title: shareWithFriendsTxt),
            10.sh,
            _divider(),
            10.sh,
            _myAccountTxt(heading: settingsTxt),
            _detailsOptions(controller, title: passcodeTxt),
            _detailsOptions(controller,
                title: darkModeTxt,
                isSwitchRequired: true,
                click: controller.darkMode),
            _detailsOptions(controller, title: helpSupportTxt),
            _detailsOptions(controller, title: termsConditionsTxt),
            _detailsOptions(controller, title: logoutTxt,ontap: (){
              /*DialogHelper.showConfirmationDialog(title: "Humble Warrior",
                  description: "Are you sure?",
                  actions: [Button(label: "cancel",
                buttonSize: ButtonSize.medium,
                padding: 4.pa,
                onTap: DialogHelper.closeDialog,),
                    Button(label: "ok",
                      buttonSize: ButtonSize.medium,
                      padding: 4.pa,
                      onTap: DialogHelper.closeDialog,)
                  ]);*/
            }),
            AppText('${appVersionTxt} V 1.0'),
            10.sh,
          ]),
        ),
      ),
    );
  }

  _profileImage(MyAccountController controller) {
    return Column(
      children: [
        Obx(
              () => Container(
            alignment: Alignment.center,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
            ),
            child: controller.imageUrl.isEmpty?InkWell(
              onTap: (){
                _openBottomSheet();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, color: Colors.black, size: 40),
                  5.sh,
                  AppText(addPhotoTxt),
                ],
              ),
            ): ClipRRect(
              borderRadius: BorderRadius.circular(150),
              child: Image.file(
               File(controller.imageUrl.value),
                fit: BoxFit.fill,
                height: 145,
                width: 145,
              ),
            ),
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
            top: isSwitchRequired ? 0 : 12,
            bottom: isSwitchRequired ? 0 : 12),
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
                      value: title == darkModeTxt
                          ? controller.checkDark.value
                          : controller.checkNotification.value,
                      activeColor: Colors.lightGreen.shade600,
                      inactiveTrackColor: Colors.red,
                      thumbColor: MaterialStateProperty.all(Colors.white),
                      onChanged: (_) {
                        click();
                      },
                    ),
                  ),
                )
              : SizedBox(),
        ]),
      ),
    );
  }

  Future<void> _openBottomSheet() async {
    return showCupertinoModalPopup<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: CommonUtils.header(),
          actions: <Widget>[
            CommonUtils.actionButton(
             cameraTxt,
              onTap: () {
               controller.getImageCamera();
              //  CommonUtils().getImagePath(imageSource: ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            CommonUtils.actionButton(
              galleryTxt,
              onTap: () {
                controller.getImageGallery();
              //  CommonUtils().getImagePath(imageSource: ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
          ],
          cancelButton: CommonUtils.cancelButton(),
        );
      },
    );
  }

}
