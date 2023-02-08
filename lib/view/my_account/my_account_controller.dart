import 'package:get/get.dart';

class MyAccountController extends GetxController{

  RxBool check = true.obs;
  RxBool checkNotification = true.obs;
  RxBool checkDark = true.obs;
  RxBool isSwitch = false.obs;

  void switchFunc(){
    checkNotification.value = !checkNotification.value;
  }

  void darkMode(){
    checkDark.value = !checkDark.value;
  }

}