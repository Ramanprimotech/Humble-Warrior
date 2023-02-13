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
    const ProductImages(
            image:
                "https://png.pngtree.com/element_our/20190529/ourmid/pngtree-beautiful-red-tube-top-dress-image_1217088.jpg",
            name: "Dress")
        .add();
    const ProductImages(
            image:
                "https://www.bigw.com.au/medias/sys_master/images/images/hb0/hcf/33475806134302.jpg",
            name: "T-Shirt")
        .add();
    const ProductImages(
            image:
                "https://png.pngtree.com/png-clipart/20210801/original/pngtree-indian-wedding-rich-saree-for-women-png-image_6585178.jpg",
            name: "Saree")
        .add();
    const ProductImages(
            image:
                "https://www.freepnglogos.com/uploads/women-shoes-png/pink-women-shoes-png-image-icons-and-png-backgrounds-1.png",
            name: "Footwear")
        .add();
    const ProductImages(
            image:
                "https://www.pngfind.com/pngs/m/505-5055598_your-engagement-pre-engagement-ring-hd-png-download.png",
            name: "Rings")
        .add();
    const ProductImages(
            image:
                "https://www.pngfind.com/pngs/m/162-1629667_18-handbag-hd-png-download.png",
            name: "Purse")
        .add();
    const ProductImages(
            image:
                "https://e7.pngegg.com/pngimages/550/602/png-clipart-cosmetics-desktop-foundation-lipstick-makeup-miscellaneous-cream.png",
            name: "Cosmetics")
        .add();

    focusNode.addListener(() {
      debugPrint("${focusNode.hasFocus}");
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

class ProductImages {
  final String name;
  final String image;

  const ProductImages({
    required this.name,
    required this.image,
  });

  void add() {
    productImagesList.add(this);
  }

  static List<ProductImages> productImagesList = [];
}
