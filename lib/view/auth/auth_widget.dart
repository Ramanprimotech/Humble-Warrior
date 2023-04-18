import 'package:humble_warrior/hw.dart';

class AuthWidget {
  Widget optionWidget(
      {Color? bckClr,
      Color? textClr,
      String? title,
      String? imagePath,
      required Function onTap}) {
    final AccountOptionTheme accountOptionTheme =
        Theme.of(Get.context!).extension<AccountOptionTheme>()!;
    return InkWell(
      onTap: () => CommonUtils.toCheckInternet(context: context,action: () async {
        onTap();
      }),
      child: Container(
        height: 40,
        width: Get.width * .8,
        decoration: BoxDecoration(
          color: accountOptionTheme.backGroundColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            imagePath.isNotEmptyAndNotNull
                ? Image.asset(
                    imagePath!,
                    fit: BoxFit.cover,
                    height: 28.h,
                    width: 28.h,
                  ).centered().p(2).px(4)
                : const SizedBox(
                    width: 30,
                  ).centered().p(2).px(4),
            AppText(title!,
                color: accountOptionTheme.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600),
            const SizedBox(width: 40),
          ],
        ),
      ).py(12).px(20),
    );
  }
}


