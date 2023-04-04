import 'dart:io';

import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/view/my_account/account_details/account_details_controller.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AccountDetailsController accountController = Get.find();
    return Scaffold(
        bottomNavigationBar: bottomNavigationWidget(context),
        body: Obx(
          () => accountController.userCheck.value == false
              ? SafeArea(
                  child: Column(
                    children: [
                      // 50.shb,
                      CommonWidgets.titleBar(context,
                          title: accountDetailsTxt, fontSize: 20),
                      150.shb,
                      loginFirst(context),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width,
                      height: Get.height / 2.5,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.fill,
                        opacity: 0.7,
                        image: AssetImage(ImagePathAssets.backgroundImg),
                      )),
                      child: Column(
                        children: [
                          50.shb,
                          CommonWidgets.titleBar(context,
                              title: accountDetailsTxt, fontSize: 20),
                          const Spacer(),
                          profileImg(),
                          const Spacer(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            50.shb,
                            heading(headingTitle: "Name"),
                            5.shb,
                            subTitle(title: accountController.username),
                            20.shb,
                            heading(headingTitle: "Email"),
                            5.shb,
                            subTitle(title: accountController.user),
                            20.shb,
                            heading(headingTitle: 'Phone Number'),
                            5.shb,
                            subTitle(
                                title: accountController.userPhone.toString()),
                            20.shb,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ));
  }

  heading({headingTitle}) {
    return Padding(
      padding: 20.pl,
      child: AppText(
        '$headingTitle',
        fontSize: 14,
      ),
    );
  }

  subTitle({title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            '$title',
            fontSize: 18,
          ),
          Divider(
            color: Theme.of(Get.context!).iconTheme.color!,
            thickness: 2,
          ),
        ],
      ),
    );
  }

  profileImg() {
    AccountDetailsController accountController = Get.find();
    MyAccWidget myAccWidget = MyAccWidget(context: Get.context!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(
          () => Container(
            alignment: Alignment.center,
            height: 120,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 3),
                  )
                ]),
            child: accountController.imageUrl.isEmpty
                ? InkWell(
                    onTap: () {
                      // _openBottomSheet();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        myAccWidget.profileText(
                            firstName: accountController.username),
                      ],
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: Image.file(
                      File(accountController.imageUrl.value),
                      fit: BoxFit.fill,
                      height: 145,
                      width: 145,
                    ),
                  ),
          ),
        ),
        10.shb,
        (accountController.username == "" ||
                accountController.username == "null" ||
                accountController.username == "N/A")
            ? const AppText("N/A",
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)
            : AppText(
                accountController.username,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
      ],
    );
  }

  Widget loginFirst(context) {
    return CommonWidgets.errorAPI(
        height: 150,
        buttonTitle: gotoLoginTxt,
        errorText: accessingMsgTxt,
        context: context,
        onPress: () {
          Get.offAllNamed(AppRoutes.loginPage);
        });
  }
}
