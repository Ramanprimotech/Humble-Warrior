
import 'dart:developer';

import 'package:flutter/material.dart';
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

  const WebViewScreenWidget({
    Key? key,
    required this.url,
     this.title,
  }) : super(key: key);

  @override
  State<WebViewScreenWidget> createState() => _WebViewScreenWidgetState();
}

class _WebViewScreenWidgetState extends State<WebViewScreenWidget> {
  late WebViewController _webViewController;

  bool canGoBool = false;
  bool loading = false;
  bool errorBool = false;
  String  errorText = "";

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
            // Update loading bar.
          },
          onPageStarted: (String url) {
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
            log(error.description,name : "web Check" ,error : error.description);
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
              _webViewController.goBack();
            },
          )
        ),
        automaticallyImplyLeading: canGoBool,
        title: AppText(
          widget.title??"",
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
                  child: Column(children: [
                    AppText(errorText,
                        color: dialogueThemeExtention.textColor, fontSize: 20),
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
                      )
                    ],
                  ),
                )
              : WebViewWidget(
                  key:widget.title!=null ? Key(widget.title!) : null,
                  controller: _webViewController,
                ),
    );
  }
}
