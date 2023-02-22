import 'package:flutter/material.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AmazonWebView extends StatefulWidget {
  const AmazonWebView({super.key});

  @override
  State<AmazonWebView> createState() => _AmazonWebViewState();
}

class _AmazonWebViewState extends State<AmazonWebView> {
  late WebViewController _webViewController;

  bool canGoBool = false;
  bool loading = false;
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
        Uri.parse("https://www.amazon.com/shop/influencer-1604f2b0"),
      );
    super.initState();
  }

  Future canGo() async {
    canGoBool = await _webViewController.canGoBack();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // initState(() {});

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
        title: const AppText(
          myAmazonTxt,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: loading
          ? Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
              key: const Key("amazon"),
              controller: _webViewController,
            ),
    );
  }
}
