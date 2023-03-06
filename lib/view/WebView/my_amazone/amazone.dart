import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/decorations.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/app_icons.dart';
import '../../../utils/theme_extention/custom_notice_theme_extention.dart';
import '../web_view.dart';

class AmazonWebView extends StatelessWidget {
  const AmazonWebView({super.key});


  @override
  Widget build(BuildContext context) {
 return const WebViewScreenWidget(title: hwAmazonTxt,url: "https://www.amazon.com/shop/influencer-1604f2b0",key: Key(hwAmazonTxt),);
  }
}
