import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';

import '../../utils/app_strings.dart';
import '../../utils/app_text.dart';
import '../../utils/common/common_functionality.dart';
import 'my_account_controller.dart';

class MyAccWidget {
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
              color: Colors.grey.shade200,
            ),
            child: controller.imageUrl.isEmpty
                ? InkWell(
                    onTap: () {
                      _openBottomSheet();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.camera_alt,
                            color: Colors.black, size: 40),
                        5.sh,
                        const AppText(addPhotoTxt),
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
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.only(
            left: 15,
            right: 5,
            top: isSwitchRequired ? 0 : 12,
            bottom: isSwitchRequired ? 0 : 12),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 7),
        width: MediaQuery.of(Get.context!).size.width,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade600,
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 3),
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
                      onChanged: (value) {
                        click();
                      },
                    ),
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
