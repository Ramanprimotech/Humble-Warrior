import 'package:humble_warrior/hw.dart';

abstract class DialogHelper {
  static final FToast _fToast = FToast();
  static bool _isToastInitialized = false;

  static void _initializeToast(BuildContext context) {
    if (_isToastInitialized) {
      return;
    }
    _fToast.init(context);
    _isToastInitialized = true;
  }

  static void showLoadingDialog({
    String label = 'Loading . . .',
    bool showLabel = true,
  }) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppColors.primary),
              if (showLabel) ...[
                const SizedBox(width: 16),
                AppText(
                  label,
                  fontSize: 18,
                  maxLines: 1,
                ),
              ],
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Future<void> showAlertDialog(
    String message, {
    String? title,
    double? textFont,
    required VoidCallback onTap,
  }) async {
    DialogueThemeExtention dialogueThemeExtention =
        Theme.of(Get.context!).extension<DialogueThemeExtention>()!;
    await Get.dialog(
      Dialog(
        shape: 16.shape,
        surfaceTintColor: Colors.transparent,
        backgroundColor: dialogueThemeExtention.backGroundColor,
        child: MediaQueryWidget(
          child: Padding(
            padding: 16.pa,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  title ?? "Humble Warrior",
                  fontSize: 22,
                  maxLines: 3,
                  fontWeight: FontWeight.bold,
                  padding: 8.pb,
                  textAlign: TextAlign.center,
                ),
                AppText(
                  message,
                  fontSize: textFont ?? 18,
                  maxLines: 6,
                  textAlign: TextAlign.center,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        // fixedSize: const Size(, 35),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: dialogueThemeExtention.buttonColor,
                      ),
                      onPressed: onTap,
                      child: const AppText(
                        "Ok",
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
      // barrierColor: _themeController.isDarkMode ? AppColors.barrierDark : AppColors.barrierLight,
    );
  }

  static Future<void> showConfirmationDialog({
    required BuildContext context,
    required void Function() action,
    void Function()? cancelAction,
    String? actionLabel,
    String? cancelLabel,
    String? message,
  }) async {
    DialogueThemeExtention dialogueThemeExtention =
        Theme.of(Get.context!).extension<DialogueThemeExtention>()!;
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) => AlertDialog(
        surfaceTintColor: Colors.transparent,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.spaceAround,
        backgroundColor: dialogueThemeExtention.backGroundColor,
        elevation: 5,
        title: AppText(message ?? "Are you Sure?",
            color: dialogueThemeExtention.textColor,
            textAlign: TextAlign.center,
            maxLines: 2,
            fontSize: 20),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 5,
              fixedSize: const Size(90, 35),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: AppColors.primary,
            ),
            onPressed: action,
            child: AppText(
              actionLabel ?? 'OK',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          OutlinedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.resolveWith((states) => 5),
              shape: MaterialStateProperty.resolveWith((states) =>
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              side: MaterialStateProperty.resolveWith(
                (states) => BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
            ),
            onPressed: cancelAction ??
                () {
                  Get.back();
                },
            child:
                AppText(cancelLabel ?? 'Cancel', fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  static showMaintenanceDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        final AccountOptionTheme accountOptionTheme =
        Theme.of(Get.context!).extension<AccountOptionTheme>()!;
        ThemeController themeController = Get.find();
        return AlertDialog(
            elevation: 3,
            shadowColor: Theme.of(context).extension<ShadowTheme>()!.shadowColor!,
            backgroundColor: accountOptionTheme.backGroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.asset(
                themeController.themeMode == ThemeMode.dark
                    ? ImagePathAssets.hwLogoDarkMode
                    : ImagePathAssets.hwLogo,
                width: Get.width * .30,
              ),
            ).centered().pLTRB(0, 10, 0, 5),
            content: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                   "Exciting changes are on the way.",
                    // "We've just released a new update for the app which includes some great new features! To make sure you're getting the most out of the app, we recommend you update the app.",
                    color: accountOptionTheme.textColor,
                    fontSize: 17,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    padding: 6.pv,
                  ),
                  AppText(
                    "Thanks for your patience, we'll be back shortly.",
                    color: accountOptionTheme.textColor,
                    fontSize: 16,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    padding: 16.pv,
                  ),
                ],
              ),
            )

          // const Text("Please install the updated version from TestFlight"),
          // actions: <Widget>[
          //    IconButton(
          //     icon:  const Text("OK"),
          //     onPressed: () {
          //       // Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }

  static void showErrorDialog({
    String title = 'Error',
    String description = "Unknown error occurred",
    int? maxLines = 3,
  }) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: 8.pa.copyWith(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                  size: 50,
                ),
              ),
              8.shb,
              AppText(
                title,
                fontSize: 18,
                padding: 8.pl,
                fontWeight: FontWeight.bold,
              ),
              8.shb,
              AppText(
                description,
                maxLines: maxLines,
                padding: 8.pl,
              ),
              16.shb,
              const Button(
                label: 'Close',
                onTap: closeDialog,
                backgroundColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showToast(
    BuildContext context,
    String message, [
    IconData? icon,
  ]) {
    _initializeToast(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppColors.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            const Icon(
              Icons.add,
              color: AppColors.white,
            ),
            // AppIcon(icon, color: AppColors.white),
            const SizedBox(width: 8),
          ],
          AppText(message, color: AppColors.white),
        ],
      ),
    );

    _fToast.showToast(child: toast);
  }

  static void closeDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  static Future<void> logoutDialog(
      {required BuildContext context, required void Function() onTap}) async {
    DialogueThemeExtention dialogueThemeExtention =
        Theme.of(context).extension<DialogueThemeExtention>()!;
    showDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (context) => AlertDialog(
        surfaceTintColor: Colors.transparent,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.spaceAround,
        backgroundColor: dialogueThemeExtention.backGroundColor,
        elevation: 5,
        title: AppText(AppStrings.logoutTitleText,
            color: dialogueThemeExtention.textColor,
            textAlign: TextAlign.center,
            fontSize: 20),
        content:  RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              children: [
          TextSpan(text: "${AppStrings.logoutSubText} ",style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.displaySmall!.color!)),
          TextSpan(text: AppStrings.logoutText,style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.displaySmall!.color!, fontWeight: FontWeight.bold)),
        ]),
        ),
        actions: [
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: ButtonStyle(
                      elevation:
                      MaterialStateProperty.resolveWith((states) => 5),
                      shape: MaterialStateProperty.resolveWith((states) =>
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      // overlayColor: MaterialStateProperty.all(AppColors.primary),
                      side: MaterialStateProperty.resolveWith(
                            (states) => BorderSide(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                    ),
                    onPressed: () {
                      onTap();
                    },
                    child: const AppText('Log out', fontWeight: FontWeight.w600),
                  ),
                ),
                16.swb,
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      // fixedSize: const Size(90, 35),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: const AppText('Cancel',
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
