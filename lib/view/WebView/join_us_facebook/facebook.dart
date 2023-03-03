
import 'package:flutter/material.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import '../web_view.dart';

class FaceBookWebView extends StatelessWidget {
  const FaceBookWebView({super.key});


  @override
  Widget build(BuildContext context) {
    return const WebViewScreenWidget(title: joinUsTxt,url: "https://www.facebook.com/groups/209617206226617",key: Key(joinUsTxt),);
  }
}
