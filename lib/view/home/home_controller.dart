import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/abstract_enums/search_bar.dart';
import 'package:humble_warrior/modals/response/brands_response_mdel.dart';
import 'package:humble_warrior/modals/response/home_categories_response_model.dart';
import 'package:humble_warrior/modals/response/product_category_response.dart';
import 'package:humble_warrior/network/api_call.dart';

class HomeScreenController extends GetxController implements SearchActions {
  final TextEditingController searchTextController = TextEditingController();

  final ScrollController brandScrollController =
      ScrollController(initialScrollOffset: 0.0);
  final ScrollController productScrollController =
      ScrollController(initialScrollOffset: 0.0);

  RxBool listBack = false.obs;
  RxBool listForward = true.obs;
  RxBool brandListBack = false.obs;
  RxBool brandListForward = true.obs;

  final FocusNode focusNode = FocusNode();
  ValueNotifier<bool> keyboardIsOpened = ValueNotifier(true);

  void getKeyBoard(BuildContext context) {
    keyboardIsOpened.value =
        (MediaQuery.of(Get.context!).viewInsets.bottom != 0.0);
  }

  @override
  void onInit() {
    productScrollController.addListener(() {
      listForward.value = productScrollController.offset !=
          productScrollController.position.maxScrollExtent;
      listBack.value = productScrollController.offset !=
          productScrollController.initialScrollOffset;
    });

    brandScrollController.addListener(() {
      brandListForward.value = brandScrollController.offset !=
          brandScrollController.position.maxScrollExtent;
      brandListBack.value = brandScrollController.offset !=
          brandScrollController.initialScrollOffset;
    });

    focusNode.addListener(() {
      debugPrint("${focusNode.hasFocus}");
      getKeyBoard(Get.context!);
    });

    super.onInit();
  }

  // List<String> products = [
  //   "https://www.freepnglogos.com/uploads/shoes-png/mens-shoes-png-transparent-images-images-11.png",
  //   "https://e7.pngegg.com/pngimages/757/605/png-clipart-women-s-yellow-sleeveless-dress-dress-see-through-clothing-top-women-dress-tshirt-orange.png",
  //   "https://www.pngfind.com/pngs/m/162-1629667_18-handbag-hd-png-download.png",
  //   "https://www.pngfind.com/pngs/m/505-5055598_your-engagement-pre-engagement-ring-hd-png-download.png"
  // ];

  // Future<List<BrandDetails>> allBrands() async {
  //   return await CallAPI.allBrands();
  // }
  Future<List<BrandDetails>> allBrands() async {
    // List<BrandDetails> data = [];
    // data.add(BrandDetails(
    //     brandImage: ImagePathAssets.nikeIcon,
    //     brandName: nikeTxt,
    //     brandLink: brandLink));
    // data.add(BrandDetails(
    //     brandImage: ImagePathAssets.adidasIcon,
    //     brandName: adidasTxt,
    //     brandLink: brandLink));
    // data.add(BrandDetails(
    //     brandImage: ImagePathAssets.reebokIcon,
    //     brandName: reebokTxt,
    //     brandLink: brandLink));
    // data.add(BrandDetails(
    //     brandImage: ImagePathAssets.gucciIcon,
    //     brandName: gucciTxt,
    //     brandLink: brandLink));
    // data.add(BrandDetails(
    //     brandImage: ImagePathAssets.nikeIcon,
    //     brandName: nikeTxt,
    //     brandLink: brandLink));
    // data.add(BrandDetails(
    //     brandImage: ImagePathAssets.adidasIcon,
    //     brandName: adidasTxt,
    //     brandLink: brandLink));
    // data.add(BrandDetails(
    //     brandImage: ImagePathAssets.reebokIcon,
    //     brandName: reebokTxt,
    //     brandLink: brandLink));
    // data.add(BrandDetails(
    //     brandImage: ImagePathAssets.gucciIcon,
    //     brandName: gucciTxt,
    //     brandLink: brandLink));
    // return data;
    // return data;
    return CallAPI.allBrands();
  }

  Future<List<ProductCategoryItem>> productCategoryAPI() async {
    // const ProductImages(image: ImagePathAssets.giftIcon, name: giftTxt).add();
    // const ProductImages(
    //         image: ImagePathAssets.giftForMomIcon, name: giftForMomTxt)
    //     .add();
    // const ProductImages(image: ImagePathAssets.houseIcon, name: homeTxt).add();
    // const ProductImages(image: ImagePathAssets.beautyIcon, name: beautyTxt)
    //     .add();
    // const ProductImages(image: ImagePathAssets.menIcon, name: menTxt).add();
    // const ProductImages(image: ImagePathAssets.kidsIcon, name: kidsTxt).add();
    // const ProductImages(image: ImagePathAssets.foodIcon, name: kitchenTxt)
    //     .add();
    // const ProductImages(image: ImagePathAssets.travelIcon, name: travelTxt)
    //     .add();
    // const ProductImages(image: ImagePathAssets.healthIcon, name: healthTxt)
    //     .add();
    // const ProductImages(
    //         image: ImagePathAssets.womensFashionIcon, name: womensFashionTxt)
    //     .add();
    // const ProductImages(image: ImagePathAssets.outdoorIcon, name: outdoorTxt)
    //     .add();
    // const ProductImages(image: ImagePathAssets.packingIcon, name: packingTxt)
    //     .add();
    // const ProductImages(image: ImagePathAssets.fitnessIcon, name: fitnessTxt)
    //     .add();
    // const ProductImages(image: ImagePathAssets.orderIcon, name: foodTxt).add();
    // const ProductImages(image: ImagePathAssets.jewelryIcon, name: jewelryTxt)
    //     .add();
    // const ProductImages(image: ImagePathAssets.babyIcon, name: babyTxt).add();
    // const ProductImages(image: ImagePathAssets.booksIcon, name: booksTxt).add();
    // const ProductImages(image: ImagePathAssets.vehicleIcon, name: vehiclesTxt)
    //     .add();
    // const ProductImages(image: ImagePathAssets.petsIcon, name: petsTxt).add();

    return CallAPI.productCategoryAPI();
  }

  Future<List<HomeCategoryList>> homeCategories() async {
    // List<HomeCategoryList> data = [];
    // data.add(HomeCategoryList(
    //     categoryName: donnaDailyDealTxt.upperCamelCase,
    //     categoryImage: ImagePathAssets.donnaDailyDealImage,
    //     id: 0));
    // data.add(HomeCategoryList(
    //     categoryName: donnaFavouriteDealTxt.upperCamelCase,
    //     categoryImage: ImagePathAssets.donnaFavDealImage,
    //     id: 1));
    // data.add(HomeCategoryList(
    //     categoryName: donnaFrontPageDealTxt.upperCamelCase,
    //     categoryImage: ImagePathAssets.donnaFrontDealImage,
    //     id: 2));
    // return data;
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
