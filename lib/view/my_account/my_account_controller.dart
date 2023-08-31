import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/view/my_account/my_account_repo.dart';

class MyAccountController extends GetxController {
  RxBool check = true.obs;
  RxBool checkNotification = true.obs;
  RxBool checkDark = false.obs;
  RxBool isSwitch = false.obs;
  RxBool userCheck = false.obs;
  String user = "";
  String username = "";
  String userPhone = "";
  RxString userImg = "".obs;
  late BuildContext context;
  ThemeController themeController = Get.find();
  BottomNavigationController controller = Get.find();

  final _myAccountRepo = Get.put(MyAccountRepo());

  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  // Rx<File?> imagePath = File("").obs;
  File? imagePath;
  // RxString imageUrl = "".obs;

 /* Future<void> getImageGallery() async {
    imagePath =
        await CommonUtils().getImagePath(imageSource: ImageSource.gallery);
    imageUrl.value = imagePath!.path;
  }*/


  Future<void> getData() async {
    userCheck.value =
        await SharePreferenceData.getBoolValuesSF(spIsLogged) ?? false;
    user = await SharePreferenceData.getStringValuesSF(userEmail) ?? "";
    username = await SharePreferenceData.getStringValuesSF(userName) ?? "";
    userPhone = await SharePreferenceData.getStringValuesSF(userPhoneNumber) ?? "";
    userImg.value = await SharePreferenceData.getStringValuesSF(userProfilePic) ?? "";
    debugPrint("images1 ${userImg.value.toString()}");
  }

  void message(context) {
    DialogHelper.showToast(context, stayTunedtxt);
  }

  /*Future<void> getImageCamera() async {
    imagePath =
        await CommonUtils().getImagePath(imageSource: ImageSource.camera);
    imageUrl.value = imagePath!.path;
  }*/

  void switchFunc(BuildContext context) async{
    DialogHelper.showLoadingDialog();
    _myAccountRepo.updateNotification(status: !checkNotification.value).then((message) async{
      if(message?.isBlank == false){
        DialogHelper.showToast(context, message!);
      }
      checkNotification.value = await _myAccountRepo.notificationStatus();
      DialogHelper.closeDialog();
    });
    update();
  }

  void darkMode() {
    checkDark.value = !checkDark.value;
    Get.changeThemeMode(checkDark.value ? ThemeMode.dark : ThemeMode.light);
    themeController.upgradeFun(checkDark.value);
    themeController
        .setThemeMode(checkDark.value ? ThemeMode.dark : ThemeMode.light);

    SharePreferenceData.addBoolToSF("mode", checkDark.value);
    update();
  }

  Future<void> logout() async {
    HiveService service = Get.find<HiveService>();
    Box<ProductDetailsResponse> box = service.box;
    await FirebaseAuth.instance.signOut().then((value) async {
      await SharePreferenceData.clear();
      isLoggedIn = false;
      await SharePreferenceData.addBoolToSF(spIsEntered, false);
      controller.selectedIndex = 0;
      userLogout();
      Get.offAllNamed(AppRoutes.loginPage);
    });
  }

  userLogout() async {
    try {
      if (Platform.isAndroid) {

        await GoogleSignIn(
            clientId:
            DefaultFirebaseOptions.currentPlatform.androidClientId)
            .signOut();
      } else if (Platform.isIOS) {

        await GoogleSignIn(
            clientId: DefaultFirebaseOptions.currentPlatform.iosClientId)
            .signOut();
      }
    }
    catch(e){
      debugPrint("error -->   $e");
    }
  }

  _deleteDatabase(){
    HiveService service = Get.find<HiveService>();
    Box<ProductDetailsResponse> box = service.box;
    return box.clear();
  }

  // Future<bool> deleteMyAccount() async{
  //   final user = FirebaseAuth.instance.currentUser;
  //   if(user != null){
  //     await user.delete().then((value)  async{
  //       await SharePreferenceData.clear();
  //       FirebaseAuth.instance.signOut();
  //       isLoggedIn = false;
  //       await SharePreferenceData.addBoolToSF(spIsEntered, false);
  //       controller.selectedIndex = 0;
  //       userLogout();
  //       _deleteDatabase();
  //     });
  //     return true;
  //   }else{
  //     return false;
  //   }
  // }

  Future<bool> deleteMyAccount() async{
    final user = FirebaseAuth.instance.currentUser;
    if(user != null){
      await user.delete().whenComplete(()  async{
        await SharePreferenceData.clear();
        isLoggedIn = false;
        await SharePreferenceData.addBoolToSF(spIsEntered, false);
        controller.selectedIndex = 0;
        _deleteDatabase();
        userLogout();
      });
      return true;
    }else{
      return false;
    }
  }

  loginPage() {
    isLoggedIn = false;
    controller.selectedIndex = 0;
    controller.update();
    controller.selectedIndex.toString().log();
    Get.offAllNamed(AppRoutes.loginPage);
  }

  @override
  void onInit() async {
    checkDark.value = themeController.themeMode == ThemeMode.dark;
    await getData();
    checkNotification.value = await _myAccountRepo.notificationStatus();
    super.onInit();
  }

  void tapPasscode() async {
    FToast().init(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var pass = sharedPreferences.getString('PASSCODE');
    if (pass == null || pass == "") {
      _showLockScreen(
        Get.context!,
        opaque: false,
        cancelButton: const Text(
          'Cancel',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          semanticsLabel: 'Cancel',
        ),
      );
    } else {

      DialogHelper.showConfirmationDialog(
        context: context,
        message: confirmPasscodeTxt,
        cancelLabel: "Change",
        actionLabel: "Remove",
        cancelAction: () {
          Navigator.of(context, rootNavigator: true).pop();
          _showLockScreen(
            context,
            opaque: false,
            cancelButton: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
              ),
              semanticsLabel: 'Cancel',
            ),
          );
        },
        action: () async {
          Navigator.of(context, rootNavigator: true).pop();
          SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

          var pass = sharedPreferences.getString('PASSCODE');
          if (pass == null || pass == "") {
            DialogHelper.showToast(context, passcodeNotSetTxt);
          } else {
            sharedPreferences.remove('PASSCODE');
            DialogHelper.showToast(context, removedPasscodeTxt);
          }
        },
      );
    }
  }

  _showLockScreen(
    BuildContext context, {
    required bool opaque,
    CircleUIConfig? circleUIConfig,
    KeyboardUIConfig? keyboardUIConfig,
    Widget? cancelButton,
    List<String>? digits,
  }) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: opaque,
        pageBuilder: (context, animation, secondaryAnimation) => PasscodeScreen(
          title: const Text(
            'Set Passcode',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          circleUIConfig: circleUIConfig,
          keyboardUIConfig: keyboardUIConfig,
          passwordEnteredCallback: _passcodeEntered,
          // cancelButton: cancelButton!,
          cancelButton: cancelButton!,
          deleteButton: const Text(
            'Delete',
            style: TextStyle(fontSize: 16, color: Colors.white),
            semanticsLabel: 'Delete',
          ),
          shouldTriggerVerification: _verificationNotifier.stream,
          backgroundColor: Colors.black.withOpacity(0.8),
          cancelCallback: _passcodeCancelled,
          digits: digits,
          passwordDigits: 6,
        ),
      ),
    );
  }

  _passcodeEntered(String enteredPasscode) async {
    try {
      if (enteredPasscode != null) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString(spPasscode, enteredPasscode);
        if (sharedPreferences.getString(spPasscode) != null) {
          DialogHelper.showAlertDialog(
            setPasscodeTxt,
            onTap: () {
              Get.back(result: true);
              Get.back(result: true);
            },
          );
        } else {
          DialogHelper.showAlertDialog(
            resetPasscodeTxt,
            onTap: () {
              Get.back(result: true);
              Get.back(result: true);
            },
          );
        }
      }
      return;
    } catch (err) {
      DialogHelper.showErrorDialog();
      return;
    }
  }

  _passcodeCancelled() {
    Navigator.maybePop(Get.context!);
  }
}
