import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/app_icons.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_text.dart';
import '../../utils/decorations.dart';
import '../../utils/theme_extention/custom_notice_theme_extention.dart';

class WebViewScreenWidget extends StatefulWidget {
  final String url;
  final String? title;
  final bool? home;

  const WebViewScreenWidget({
    Key? key,
    required this.url,
    this.title,
    this.home = true,
  }) : super(key: key);

  @override
  State<WebViewScreenWidget> createState() => _WebViewScreenWidgetState();
}

class _WebViewScreenWidgetState extends State<WebViewScreenWidget> {
  late WebViewController _webViewController;

  bool canGoBool = false;
  bool loading = false;
  bool errorBool = false;
  String errorText = "";

  // ValueNotifier<String> loadingText = ValueNotifier("Loading....");

  @override
  void initState() {
    // TODO: implement initState
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            loading = true;
            // loadingText.value = "Loading...$progress%";
            // Update loading bar.
          },
          onPageStarted: (String url) {
            log("Web Page", name: "web Check", error: "url: ${widget.url}");

            canGo();
          },
          onPageFinished: (String url) {
            loading = false;
            canGo();
          },
          onWebResourceError: (WebResourceError error) {
            loading = false;
            errorBool = true;
            errorText = error.description;
            canGo();
            log(error.description,
                name: "web Check",
                error:
                    "type: ${error.errorType} code: ${error.errorCode} dis: ${error.description} url: ${widget.url}");
            setState(() {});
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.url),
      );
    super.initState();
  }

  @override
  void dispose() {
    _webViewController.clearCache();
    super.dispose();
  }

  Future canGo() async {
    canGoBool = await _webViewController.canGoBack();
    setState(() {});
    return canGoBool;
  }

  @override
  Widget build(BuildContext context) {
    // initState(() {});
    final DialogueThemeExtention dialogueThemeExtention =
        Theme.of(context).extension<DialogueThemeExtention>()!;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: Visibility(
            visible: canGoBool,
            child: IconButton(
              icon: AppIcons.backArrrowIos(),
              onPressed: () {
                canGo().then((value) {
                  value ? _webViewController.goBack() : Get.back();
                });
              },
            )),
        automaticallyImplyLeading: canGoBool,
        title: AppText(
          widget.title!,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: errorBool
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 150,
                  padding: 20.pa,
                  decoration: CustomBoxDecorations().shadow(context: context),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppText(errorText,
                            maxLines: 4,
                            color: dialogueThemeExtention.textColor,
                            fontSize: 16),
                        20.sh,
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            // fixedSize: const Size(, 35),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: dialogueThemeExtention.buttonColor,
                          ),
                          onPressed: () {
                            canGo();
                            loading = true;
                            errorBool = false;
                            setState(() {});
                            _webViewController.clearCache();
                            _webViewController.reload();
                          },
                          child: const AppText(retry,
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
              ),
            )
          : loading
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 15,
                      ),
                      AppText(
                        "Loading...",
                        fontSize: 24,
                      ),
                      // ValueListenableBuilder(
                      //   valueListenable: loadingText,
                      //   builder: (BuildContext context, value, Widget? widget) {
                      //     return AppText(
                      //       value,
                      //       fontSize: 24,
                      //     );
                      //   },
                      // )
                    ],
                  ),
                )
              : WebViewWidget(
                  key: widget.title != null ? Key(widget.title!) : null,
                  controller: _webViewController,
                ),
    );
  }
}
