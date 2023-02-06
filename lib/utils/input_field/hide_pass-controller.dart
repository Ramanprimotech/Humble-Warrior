import 'package:get/get.dart';

class HidePassController extends GetxController {
  final RxBool _hidePassword = true.obs;

  bool get hidePassword => _hidePassword.value;

  set hidePassword(bool hidePassword) => _hidePassword.value = hidePassword;
}
