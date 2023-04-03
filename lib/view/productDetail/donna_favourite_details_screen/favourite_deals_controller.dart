import 'dart:io';
import 'package:humble_warrior/hw.dart';

class FavouriteDealController extends GetxController {
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
}
