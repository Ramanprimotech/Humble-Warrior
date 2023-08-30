import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/view/my_account/delete_account_popup.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FToast().init(context);

    /// Controller
    MyAccountController controller = Get.find();
    final ThemeController themeController = Get.find();
    MyAccWidget myAccWidget = MyAccWidget(context: context);
    controller.context = context;

    /// Variables
    bool isDark = themeController.themeMode == ThemeMode.dark;

    double optionSpacing = 15;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: !isDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Obx(
                () => Column(children: [
                  ///Image and account details
                  if (controller.userCheck.value == true) ...[
                    myAccWidget.profileImage(),
                    optionSpacing.shb,
                    myAccWidget.divider(),
                  ],
                  optionSpacing.shb,

                  ///===> My Account
                  myAccWidget.myAccountTextFun(heading: myAccountTxt),

                  ///Account Details
                  myAccWidget.detailsOptions(controller,
                      title: accountDetailsTxt, ontap: () {
                    Get.toNamed(AppRoutes.accountDetails,id: 4);
                  }),


                  _notificationWidget(context),

                  optionSpacing.shb,
                  // myAccWidget.divider(),
                  // optionSpacing.shb,

                  ///=====>The Humble Warrior
                  myAccWidget.myAccountTextFun(heading: theHumbleWarriorTxt),

                  ///About Donna
                  myAccWidget.detailsOptions(controller, title: aboutDonna,
                      ontap: () {
                    CommonUtils.toCheckInternet(action: () {
                      Get.toNamed(AppRoutes.aboutDonna,id: 4);
                    });
                  }),

                  ///Share with friends
                  myAccWidget.detailsOptions(
                    controller,
                    title: shareWithFriendsTxt,
                    ontap: () async {
                      CommonUtils.toCheckInternet(action: () async{
                        CommonUtils()
                            .share(shareUrl: "https://humblewarrior.com/");
                      });

                    },
                  ),
                  // // optionSpacing.shb,
                  // myAccWidget.divider(),
                  optionSpacing.shb,

                  ///====>Settings
                  myAccWidget.myAccountTextFun(heading: settingsTxt),

                  ///Passcode
                  // myAccWidget.detailsOptions(controller, title: passcodeTxt,
                  //     ontap: () {
                  //   controller.tapPasscode();
                  // }),

                  ///Dark Mode
                  myAccWidget.detailsOptions(controller,
                      title: darkModeTxt,
                      isSwitchRequired: true,
                      click: controller.darkMode),

                  ///Help & Support
                  myAccWidget.detailsOptions(controller, title: helpSupportTxt,
                      ontap: () {
                    Get.to(StaticPagesScreen(ids: "89456", title: helpSupportTxt),id: 4);
                    // Get.toNamed(AppRoutes.staticPages,
                    //     arguments: ["89456", helpSupportTxt], id: 4);
                    //     DialogHelper.showToast(context, "Coming Soon");
                  }),

                  ///Term & Conditions
                  myAccWidget.detailsOptions(controller,
                      title: termsConditionsTxt, ontap: () {
                    CommonUtils.toCheckInternet(action: () {
                      Get.to(StaticPagesScreen(ids: "89453", title: termsConditionsTxt),id: 4);
                      // Get.toNamed(AppRoutes.staticPages,
                      //     arguments: ["89453", termsConditionsTxt], id: 4);
                      // Get.toNamed(AppRoutes.staticPages,
                      //    id: 4);
                    });
                  }),

                  ///Login or Logout
                  _loginOrLogout(context),

                  _deleteAccount(context),
                  10.shb
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _deleteAccount(context){
    MyAccountController controller = Get.find();
    MyAccWidget myAccWidget = MyAccWidget(context: context);
    return controller.userCheck.value == true
        ? myAccWidget.detailsOptions(
        controller,
        title: deleteMyAccount,
        textColor: AppColors.primary,
        ontap: () {
          _showDeleteAccountPopup(context);
        }
    ) : const SizedBox();
  }


  /// Login Or Logout
  Widget _notificationWidget(context) {
    MyAccountController controller = Get.find();
    MyAccWidget myAccWidget = MyAccWidget(context: context);
    // return controller.userCheck.value == true
    //   ? ///Notification
     return myAccWidget.detailsOptions(controller,
          title: notificationsTxt,
          isSwitchRequired: true,
          click: ()=> controller.switchFunc(context));
      // ) : const SizedBox.shrink();
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
            // DialogHelper.logoutDialog(
            //     context: context, onTap: controller.loginPage);
            controller.loginPage();
          });
  }


  _showDeleteAccountPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const DeleteAccountPopup();
        }
    );
  }
}
