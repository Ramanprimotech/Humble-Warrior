// import 'dart:developer';
//
// import 'package:humble_warrior/hw.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewScreenWidget extends StatefulWidget {
//   final String url;
//   final String? title;
//   final bool? home;
//
//   const WebViewScreenWidget({
//     Key? key,
//     required this.url,
//     this.title,
//     this.home = true,
//   }) : super(key: key);
//
//   @override
//   State<WebViewScreenWidget> createState() => _WebViewScreenWidgetState();
// }
//
// class _WebViewScreenWidgetState extends State<WebViewScreenWidget> {
//   late WebViewController _webViewController;
//
//   bool canGoBool = false;
//   bool loading = false;
//   bool errorBool = false;
//   String errorText = "";
//
//   // ValueNotifier<String> loadingText = ValueNotifier("Loading....");
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     _webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             loading = true;
//             // loadingText.value = "Loading...$progress%";
//             // Update loading bar.
//           },
//           onPageStarted: (String url) {
//             log("Web Page", name: "web Check", error: "url: ${widget.url}");
//
//             canGo();
//           },
//           onPageFinished: (String url) {
//             loading = false;
//             canGo();
//           },
//           onWebResourceError: (WebResourceError error) {
//             loading = false;
//             errorBool = true;
//             errorText = error.description;
//             canGo();
//             log(error.description,
//                 name: "web Check",
//                 error:
//                     "type: ${error.errorType} code: ${error.errorCode} dis: ${error.description} url: ${widget.url}");
//             setState(() {});
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.youtube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(
//         Uri.parse(widget.url),
//       );
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _webViewController.clearCache();
//     super.dispose();
//   }
//
//   Future canGo() async {
//     canGoBool = await _webViewController.canGoBack();
//     setState(() {});
//     return canGoBool;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 5,
//         centerTitle: true,
//         leading: Visibility(
//           visible: canGoBool,
//           child: AppIcons.IosBackIcon(onPress: () {
//             _webViewController.goBack();
//           }),
//         ),
//         automaticallyImplyLeading: canGoBool,
//         title: AppText(
//           fontSize: 20,
//           widget.title!,
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//       body: errorBool
//           ? CommonWidgets.errorAPI(
//               buttonTitle: retryTxt,
//               errorText: errorText,
//               context: context,
//               onPress: () {
//                 canGo();
//                 loading = true;
//                 errorBool = false;
//                 setState(() {});
//                 _webViewController.clearCache();
//                 _webViewController.reload();
//               })
//           : loading
//               ? Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       CircularProgressIndicator(),
//                       SizedBox(
//                         width: 15,
//                       ),
//                       AppText(
//                         "Loading...",
//                         fontSize: 24,
//                       ),
//                     ],
//                   ),
//                 )
//               : WebViewWidget(
//                   key: widget.title != null ? Key(widget.title!) : null,
//                   controller: _webViewController,
//                 ),
//
//       /*WebView(
//         navigationDelegate: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.youtube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//           initialUrl: "${widget.url}",
//            javascriptMode: JavascriptMode.unrestricted,
//           backgroundColor: const Color(0x00000000),
//           onPageFinished: (String url) {
//             loading = false;
//             canGo();
//           },
//           onProgress: (int progress) {
//             loading = true;
//             // loadingText.value = "Loading...$progress%";
//             // Update loading bar.
//           },
//           onPageStarted: (String url) {
//             log("Web Page", name: "web Check", error: "url: ${widget.url}");
//
//             canGo();
//           },
//           onWebResourceError: (WebResourceError error) {
//             loading = false;
//             errorBool = true;
//             errorText = error.description;
//             canGo();
//             log(error.description,
//                 name: "web Check",
//                 error:
//                 "type: ${error.errorType} code: ${error.errorCode} dis: ${error.description} url: ${widget.url}");
//             setState(() {});
//           },
//       ),*/
//     );
//   }
// }
