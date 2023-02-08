import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/common/common_functionality.dart';
import 'package:image_picker/image_picker.dart';

class ProductDetailController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode focusNode = FocusNode();
   File? imagePath;

  /// get image Path
   Future<void> getImagePath() async {
     imagePath = await CommonUtils().getImagePath(imageSource: ImageSource.gallery);
     debugPrint("Image Path $imagePath");
     update();

   }
}
