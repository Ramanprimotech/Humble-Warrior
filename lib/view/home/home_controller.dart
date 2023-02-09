import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/brands_response_mdel.dart';
import 'package:humble_warrior/network/api_call.dart';

class HomeScreenController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    HomeOptions(
            text: "FRONT PAGE DEALS",
            image:
                "https://humblewarrior.com/wp-content/uploads/2022/11/Facetune_20-06-2022-06-51-2.jpg")
        .addList();
    HomeOptions(
            text: "DONNA'S DAILY DEALS",
            image:
                "https://humblewarrior.com/wp-content/uploads/2022/11/vinex600.jpg")
        .addList();
    HomeOptions(
            text: "DONNA'S FAVOURITE THINGS",
            image:
                "https://humblewarrior.com/wp-content/uploads/2022/11/Screen-Shot-2022-01-12-at-1.58.30-PM.jpg")
        .addList();
    super.onInit();
  }

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
}

class HomeOptions {
  final String image;
  final String text;

  HomeOptions({required this.text, required this.image});

  static List<HomeOptions> homeOptionsList = [];

  void addList() {
    homeOptionsList.add(this);
  }

  void clear() {
    homeOptionsList.clear();
  }
}
