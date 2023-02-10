import 'package:get/get.dart';
import 'package:humble_warrior/view/wish_list/wish_list_controller.dart';

class WishListBindings implements Bindings{
  @override
  void dependencies(){
    Get.lazyPut(() => WishListController());
  }
}