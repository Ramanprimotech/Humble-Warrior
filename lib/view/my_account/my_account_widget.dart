import 'dart:io';

import 'package:humble_warrior/hw.dart';

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
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            child: controller.imageUrl.isEmpty
                ? InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.accountDetails,id: 4);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        profileText(firstName: controller.username),
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
        10.shb,
        (controller.username == "" ||
                controller.username == "null" ||
                controller.username == "N/A")
            ? const AppText("N/A")
            : AppText(controller.username),
        AppText(controller.user),
      ],
    );
  }

  profileText({String? firstName, String? secondName}) {
    String text = "";
    if (firstName == null ||
        firstName == "" ||
        firstName == "null" ||
        firstName == "N/A") {
      text = "NA";
    } else {
      List<String> names = firstName!.split(" ");

      if (names.length == 1) {
        text = names[0][0] + names[0][1];
      } else {
        text = "${names[0][0]}${names[1][0]}";
      }
    }
    return AppText(
      text.toUpperCase(),
      fontWeight: FontWeight.w900,
      fontSize: 48,
    );
  }

  divider({color}) {
    return Divider(
      color: color ?? Colors.grey.shade200,
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
      {title, bool isSwitchRequired = false, Color? textColor, ontap, click}) {
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
        height: 35,
        padding: EdgeInsets.only(
            left: 16,
            right: 5,
            top: isSwitchRequired ? 0 : 0,
            bottom: isSwitchRequired ? 0 : 0),
        margin: 10.pv,
        width: MediaQuery.of(Get.context!).size.width,
        decoration: CustomBoxDecorations(context: context)
            .shadow(color: accountOptionTheme.backGroundColor, radius: 50),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                title,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: textColor
                // color: accountOptionTheme.textColor,
              ),
              isSwitchRequired
                  ? Obx(
                      () => SizedBox(
                        height: 35,
                        width: 60,
                        child: FittedBox(
                          child: Switch(
                            thumbIcon: thumbIcon,
                            value: title == darkModeTxt
                                ? controller.checkDark.value
                                : controller.checkNotification.value,
                            activeColor: Colors.greenAccent.shade700,
                            inactiveTrackColor: AppColors.switchInactiveColor,
                            thumbColor: MaterialStateProperty.all(Colors.white),
                            onChanged: (value) {
                              click();
                            },
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ]),
      ),
    );
  }
}
