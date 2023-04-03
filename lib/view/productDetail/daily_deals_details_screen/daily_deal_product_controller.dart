import 'dart:io';
import 'package:humble_warrior/hw.dart';

import '../../../network/api_call.dart';

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
