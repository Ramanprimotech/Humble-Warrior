import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/view/my_account/account_details/account_details_controller.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AccountDetailsController accountController = Get.find();
    return Scaffold(
        body: Obx(
      () => accountController.userCheck.value == false
          ? SafeArea(
              child: Column(
                children: [
                  // 20.shb,
                  CommonWidgets.titleBar(context,
                      title: accountDetailsTxt, fontSize: 20, onPress: () {
                    Get.back(id: 4);
                  }),
                  150.shb,
                  loginFirst(context),
                ],
              ),
            )
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 50.shb,
                  CommonWidgets.titleBar(context,
                      title: accountDetailsTxt, fontSize: 20, onPress: () {
                    Get.back(id: 4);
                  }),
                  40.shb,
                  CommonWidgets.networkImage(
                    alignment: Alignment.center,
                    width: 120,
                    height: 120,
                    isCircle: false,
                    isFill: false,
                    imageUrl: accountController.userImg.value.toString(),
                    errorImage: ImagePathAssets.hwUser,
                    fit: BoxFit.contain,
                  ),
                  20.shb,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
      padding: 20.ph,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText('$title', fontSize: 18),
          Divider(color: Theme.of(Get.context!).iconTheme.color!, thickness: 1),
        ],
      ),
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
