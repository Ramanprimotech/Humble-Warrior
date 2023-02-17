import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/abstract_enums/search_bar.dart';
import 'package:humble_warrior/modals/response/brands_response_mdel.dart';
import 'package:humble_warrior/modals/response/home_categories_response_model.dart';

class HomeScreenController extends GetxController implements SearchActions {
  final TextEditingController searchTextController = TextEditingController();

  final ScrollController brandScrollController =
      ScrollController(initialScrollOffset: 0.0);
  final ScrollController productScrollController =
      ScrollController(initialScrollOffset: 0.0);

  RxBool listBack = false.obs;
  RxBool listForward = true.obs;
  // RxBool brandListBack = false.obs;
  // RxBool brandListForward = true.obs;

  final FocusNode focusNode = FocusNode();
  ValueNotifier<bool> keyboardIsOpened = ValueNotifier(true);

  void getKeyBoard(BuildContext context) {
    keyboardIsOpened.value =
        (MediaQuery.of(Get.context!).viewInsets.bottom != 0.0);
  }

  @override
  void onInit() {
    productScrollController.addListener(() {
         listForward.value = productScrollController.offset != productScrollController.position.maxScrollExtent;
         listBack.value = productScrollController.offset != productScrollController.initialScrollOffset;
    });

    // brandScrollController.addListener(() {
    //
    //      brandListForward.value = brandScrollController.offset != brandScrollController.position.maxScrollExtent;
    //      brandListBack.value = brandScrollController.offset != brandScrollController.initialScrollOffset;
    //
    // });

    const ProductImages(image: "assets/brands/men.png", name: "Men").add();
    const ProductImages(image: "assets/brands/gift.png", name: "Gift").add();
    const ProductImages(image: "assets/brands/giftformom.png", name: "Gift For Mom").add();
    const ProductImages(image: "assets/brands/health.png", name: "Health").add();
    const ProductImages(image: "assets/brands/kids.png", name: "Kids").add();
    const ProductImages(image: "assets/brands/food.png", name: "Food").add();
    const ProductImages(image: "assets/brands/womenfashion.png", name: "Women's fashion").add();
    const ProductImages(image: "assets/brands/outdoor.png", name: "Outdoor").add();
    const ProductImages(image: "assets/brands/travel.png", name: "Travel").add();
    const ProductImages(image: "assets/brands/packaging.png", name: "Packing").add();
    const ProductImages(image: "assets/brands/fitness.png", name: "Fitness").add();
    const ProductImages(image: "assets/brands/order.png", name: "Food").add();
    const ProductImages(image: "assets/brands/jewelry.png", name: "Jewelry").add();
    const ProductImages(image: "assets/brands/baby.png", name: "Baby").add();
    const ProductImages(image: "assets/brands/books.png", name: "Books").add();
    const ProductImages(image: "assets/brands/vehicle.png", name: "vehicles").add();
    const ProductImages(image: "assets/brands/pets.png", name: "Pets").add();

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
  //
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
    List<BrandDetails> data = [];
    data.add(BrandDetails(
        brandImage: "assets/categories/nike.png",
        brandName: "Nike",
        brandLink: "https://humblewarrior.com/"));
    data.add(BrandDetails(
        brandImage: "assets/categories/reebok.png",
        brandName: "Reebok",
        brandLink: "https://humblewarrior.com/"));
    data.add(BrandDetails(
        brandImage: "assets/categories/guchi.png",
        brandName: "Gucci",
        brandLink: "https://humblewarrior.com/"));
    data.add(BrandDetails(
        brandImage: "assets/categories/adidas.png",
        brandName: "adidas",
        brandLink: "https://humblewarrior.com/"));
    return data;
  }

  Future<List<HomeCategoryList>> homeCategories() async {
    List<HomeCategoryList> data = [];
    data.add(HomeCategoryList(
        categoryName: "Donna's Daily Deals",
        categoryImage: "assets/image/donna_deals.jpeg",
        id: 0));
    data.add(HomeCategoryList(
        categoryName: "Donna's Favourite Deals",
        categoryImage: "assets/image/donna_fav.jpg",
        id: 1));
    data.add(HomeCategoryList(
        categoryName: "Donna's Front Page Deals",
        categoryImage: "assets/image/donna_front.jpeg",
        id: 2));
    return data;
    // return await CallAPI.homeCategory();
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
