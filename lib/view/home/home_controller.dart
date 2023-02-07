import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    HomeOptions(
            text: "Front Page Deals",
            image:
                "https://humblewarrior.com/wp-content/uploads/2022/11/Facetune_20-06-2022-06-51-2.jpg")
        .addList();
    HomeOptions(
            text: "Donna's Daily Deals",
            image:
                "https://humblewarrior.com/wp-content/uploads/2022/11/vinex600.jpg")
        .addList();
    super.onInit();
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
