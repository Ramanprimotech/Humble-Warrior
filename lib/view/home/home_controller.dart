import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/abstract_enums/search_bar.dart';
import 'package:humble_warrior/modals/response/brands_response_mdel.dart';
import 'package:humble_warrior/modals/response/home_categories_response_model.dart';
import 'package:humble_warrior/network/api_call.dart';

class HomeScreenController extends GetxController implements SearchActions {
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  ValueNotifier<bool> keyboardIsOpened = ValueNotifier(true);

  void getKeyBoard(BuildContext context) {
    keyboardIsOpened.value =
        (MediaQuery.of(Get.context!).viewInsets.bottom != 0.0);
  }

  @override
  void onInit() {
    focusNode.addListener(() {
      print(focusNode.hasFocus);
      getKeyBoard(Get.context!);
    });

    super.onInit();
  }

  // void unfocusNode() {
  //   log("${focusNode.hasFocus}", name: "${focusNode.hasPrimaryFocus}");
  //   focusNode.unfocus();
  //   getKeyBoard(Get.context!);
  // }

  List<String> products = [
    "https://www.freepnglogos.com/uploads/shoes-png/mens-shoes-png-transparent-images-images-11.png",
    "https://e7.pngegg.com/pngimages/757/605/png-clipart-women-s-yellow-sleeveless-dress-dress-see-through-clothing-top-women-dress-tshirt-orange.png",
    "https://www.pngfind.com/pngs/m/162-1629667_18-handbag-hd-png-download.png",
    "https://www.pngfind.com/pngs/m/505-5055598_your-engagement-pre-engagement-ring-hd-png-download.png"
  ];

  List<String> brands = [
    "https://seeklogo.com/images/A/adidas-logo-107B082DA0-seeklogo.com.png",
    "https://www.pngfind.com/pngs/m/415-4156288_image-nike-logo-just-do-it-orange-hd.png",
    "https://www.pngfind.com/pngs/m/59-595532_nike-logo-clipart-clear-ugg-australia-logo-png.png",
  ];

  Future<List<BrandDetails>> allBrands() async {
    return await CallAPI.allBrands();
  }

  Future<List<HomeCategoryList>> homeCategories() async {
    return await CallAPI.homeCategory();
  }

  @override
  void onChange(String? data) {
    // TODO: implement onChange
  }

  @override
  void onSubmit(String? data) {
    // TODO: implement onSubmit
  }

  @override
  void onTap() {
    // TODO: implement onTap
  }
}
