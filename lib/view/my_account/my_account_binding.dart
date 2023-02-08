import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:humble_warrior/view/my_account/my_account_controller.dart';

class MyAccount implements Bindings{
  @ override
  void dependencies(){
    Get.lazyPut(()=> MyAccountController());
  }
}