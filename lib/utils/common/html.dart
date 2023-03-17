import 'package:flutter/material.dart';
import 'package:humble_warrior/utils/common/common_functionality.dart';
import 'package:simple_html_css/simple_html_css.dart';

class HtmlData{
  htmlString(BuildContext context, title){
   return HTML.toRichText(context, title,
    linksCallback: (dynamic link) {
    CommonUtils().urlLauncher(url: link.toString());
  }
 ); }
}