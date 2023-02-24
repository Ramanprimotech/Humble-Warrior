import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonUtils {
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
  Future<void> urlLauncher({required String url, String? title}) async {
    // Get.to(WebViewScreenWidget(
    //   url: url,
    //   title: title,
    //   home: false,
    // ));
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  /// Copy To Clipboard
  void copyToClipboard({required String copyText}) {
    Clipboard.setData(ClipboardData(text: copyText)).then((value) {
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

  static Widget header([String? label]) {
    return AppText(
      label ?? humbleWarriorTxt,
      fontSize: 20,
      textAlign: TextAlign.center,
    );
  }

  static Widget actionButton(
    String label, {
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: const BoxDecoration(
          // color: Colors.white,
          ),
      child: CupertinoActionSheetAction(
        onPressed: onTap,
        child: AppText(
          label,
          fontSize: 16,
          color: Colors.blue,
        ),
      ),
    );
  }

  static Widget cancelButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: 12.brc,
        // color: Colors.white,
      ),
      child: CupertinoActionSheetAction(
        isDefaultAction: true,
        child: const AppText(
          cancelTxt,
          fontSize: 20,
          color: Colors.red,
        ),
        onPressed: () => Get.back(),
      ),
    );
  }
}
