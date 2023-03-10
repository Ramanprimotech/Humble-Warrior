import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/product_details_response.dart';
import 'package:humble_warrior/network/api_call.dart';
import 'package:humble_warrior/utils/common/common_functionality.dart';
import 'package:image_picker/image_picker.dart';

class DailyDealProductController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  File? imagePath;

  /// get image Path
  Future<void> getImagePath() async {
    imagePath =
        await CommonUtils().getImagePath(imageSource: ImageSource.gallery);
    debugPrint("Image Path $imagePath");
    update();
  }

  Future<List<ProductDetailsResponse>> dailyDealProductDetais(String id) async {
    return await CallAPI.productDetails(id);
  }
}
