import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:humble_warrior/hw.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CommonUtils {
  /// Share Data
  Future<void> share({required String shareUrl}) async {
    Share.share(shareUrl);
  }

  /// URl Launcher
  Future<void> urlLauncher({required String url, String? title}) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  static Future<bool> toCheckInternet({Function? action, context}) async {
    bool connect = false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      connect = false;
      // DialogHelper.showAlertDialog(
      //
      //   "Please Check your Internet  connection",
      //   title:
      //   "No Internet Connection.",
      //   onTap: () {
      //     Navigator.of(Get.context!, rootNavigator: true).pop();
      //   },
      // );

      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );

      print("No internet connection");
    } else {
      connect = true;
      if (action != null) {
        action();
      }
    }
    return connect;
  }

  /// Copy To Clipboard
  void copyToClipboard(
      {required String copyText, required BuildContext context}) {
    FToast().init(context);
    Clipboard.setData(ClipboardData(text: copyText)).then((value) {
      DialogHelper.showToast(context, clipboardTxt);
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

Widget _buildPopupDialog(BuildContext context) {
  DialogueThemeExtention dialogueThemeExtention =
  Theme.of(context).extension<DialogueThemeExtention>()!;
  return AlertDialog(

    title: const AppText("Humble Warrior", fontSize: 22, textAlign: TextAlign.center),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AppText("Please Check your Internet  connection.",
            fontSize: 16, maxLines: 3, textAlign: TextAlign.center),
        16.shb,
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                // fixedSize: const Size(, 35),
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                backgroundColor: dialogueThemeExtention.buttonColor,
              ),
              onPressed: (){
                Navigator.pop(context);
              }, child: const AppText("Ok", color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20,)),
        )
      ],
    ),
  );
}
