
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonUtils{

  /// Share Data
  Future<void> share({required String shareUrl}) async {

    Share.share(shareUrl);
    // await FlutterShare.share(
    //
    //     linkUrl: 'https://flutter.dev/', title: '',
    //
    // );
  }


  /// URl Launcher
  Future<void> urlLauncher({required String url}) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }


  /// Copy To Clipboard
  void  copyToClipboard({required String copyText}) {
  Clipboard.setData( ClipboardData(text: copyText)).then((value) {
  Get.snackbar(

  "Copied to Clipboard",
  "",
  backgroundColor: Colors.pinkAccent,
  snackPosition: SnackPosition.BOTTOM,
  );

  });

  }


  /// Image Picker

  final ImagePicker _picker = ImagePicker();


  Future<File> getImagePath({required ImageSource imageSource}) async {
    final XFile? image = await _picker.pickImage(source: imageSource);
    File imageFile = File(image!.path);

    return imageFile;
  }


}