import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/app_text.dart';

class FaceBookWebView extends StatefulWidget {
  const FaceBookWebView({super.key});

  @override
  State<FaceBookWebView> createState() => _FaceBookWebViewState();
}

class _FaceBookWebViewState extends State<FaceBookWebView> {
  late WebViewController _webViewController;

  bool canGoBool = false;

  @override
  void initState() {
    // TODO: implement initState
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            // canGo();
          },
          onPageFinished: (String url) {
            canGo();
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse("https://www.facebook.com/groups/209617206226617"),
      );
    super.initState();
  }

  Future canGo() async {
    canGoBool = await _webViewController.canGoBack();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: Visibility(
          visible: canGoBool,
          child: BackButton(
            onPressed: () {
              _webViewController.goBack();
            },
          ),
        ),
        automaticallyImplyLeading: canGoBool,
        title: AppText(
          "Join US",
          fontWeight: FontWeight.w700,
        ),
      ),
      body: WebViewWidget(
        key: const Key("amazon"),
        controller: _webViewController,
      ),
    );
  }
}
