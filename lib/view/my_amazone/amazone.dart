import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AmazonWebView extends StatefulWidget {
  const AmazonWebView({super.key});

  @override
  State<AmazonWebView> createState() => _AmazonWebViewState();
}

class _AmazonWebViewState extends State<AmazonWebView> {
  late WebViewController _webViewController;
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
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:
            WebViewWidget(key: Key("amazon"), controller: _webViewController));
  }
}
