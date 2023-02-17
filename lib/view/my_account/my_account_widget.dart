import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';

import '../../utils/app_strings.dart';
import '../../utils/app_text.dart';
import '../../utils/common/common_functionality.dart';
import '../../utils/theme_extention/account_option_theme_extentions.dart';
import 'my_account_controller.dart';

class MyAccWidget {
  final BuildContext context;

  MyAccWidget({required this.context});

  final MyAccountController controller = Get.find();

  profileImage() {
    return Column(
      children: [
        Obx(
          () => Container(
            alignment: Alignment.center,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            child: controller.imageUrl.isEmpty
                ? InkWell(
                    onTap: () {
                      // _openBottomSheet();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        profileText(firstName: controller.username),
                        // const Icon(Icons.camera_alt,
                        //     color: Colors.black, size: 40),
                        // 5.sh,
                        // const AppText(addPhotoTxt),
                      ],
                    ),
                  )
                : ClipRRect(
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
        AppText(controller.username),
        AppText(controller.user),
      ],
    );
  }

  profileText({String? firstName, String? secondName}) {
    List<String> names = firstName!.split(" ");
    String text = "";
    if (names.length == 1) {
      text = names[0][0];
    } else {
      text = "${names[0][0]}${names[1][0]}";
    }
    return AppText(
      text.toUpperCase(),
      fontWeight: FontWeight.w900,
      fontSize: 54,
    );
  }

  divider() {
    return Divider(
      color: Colors.grey.shade200,
      height: 2,
    );
  }

  myAccountTextFun({heading}) {
    return Align(
      alignment: Alignment.topLeft,
      child: AppText(heading, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  detailsOptions(MyAccountController controller,
      {title, bool isSwitchRequired = false, ontap, click}) {
    final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        // Thumb icon when the switch is selected.
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.check, size: 0);
        }
        return const Icon(Icons.close, size: 0);
      },
    );
    final AccountOptionTheme accountOptionTheme =
        Theme.of(context).extension<AccountOptionTheme>()!;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 45,
        padding: EdgeInsets.only(
            left: 15,
            right: 5,
            top: isSwitchRequired ? 0 : 12,
            bottom: isSwitchRequired ? 0 : 12),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 7),
        width: MediaQuery.of(Get.context!).size.width,
        decoration: BoxDecoration(
            color: accountOptionTheme.backGroundColor,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade600,
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 0),
              )
            ]),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: accountOptionTheme.textColor,
              ),
              isSwitchRequired
                  ? Obx(
                      () => Switch(
                        thumbIcon: thumbIcon,
                        value: title == darkModeTxt
                            ? controller.checkDark.value
                            : controller.checkNotification.value,
                        activeColor: AppColors.switchActiveColor,
                        inactiveTrackColor: AppColors.switchInactiveColor,
                        thumbColor: MaterialStateProperty.all(Colors.white),
                        onChanged: (value) {
                          click();
                        },
                      ),
                    )
                  : const SizedBox(),
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
