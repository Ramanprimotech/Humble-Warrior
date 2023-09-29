import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:humble_warrior/hw.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
      DialogHelper.showAlertDialog(
        "Please Check your Internet  connection.",
        title: "Humble Warrior",
        onTap: () {
          Navigator.of(Get.context!, rootNavigator: true).pop();
        },
      );
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

  ///For custom loading
  static void onLoading(BuildContext context, bool iSloading) {
    if (iSloading == true) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: AppColors.primary),
                  const SizedBox(
                    width: 10.0,
                  ),
                  // new Text("Please wait..."),
                ],
              ),
            ),
          );
        },
      );
    } else {
      Navigator.of(context, rootNavigator: true).pop();
    }
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

class CommonWebView extends StatelessWidget {
  CommonWebView({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  Widget build(BuildContext context) {
    final Completer<WebViewController> _controller =
    Completer<WebViewController>();
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onPageStarted: (String url) {
            CommonUtils.onLoading(context, true);
            print('Page started loading');
          },
          onPageFinished: (String url) {
            print('Page finished loading');
           CommonUtils.onLoading(context, false);
          },
          gestureNavigationEnabled: true,
        ),
      ),
    );
  }

}
