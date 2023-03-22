import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:humble_warrior/utils/common/common_functionality.dart';
import 'package:humble_warrior/utils/extensions.dart';
// import 'package:simple_html_css/simple_html_css.dart';
// import 'package:simple_html_css/simple_html_css.dart';

class HtmlData {
  htmlString(BuildContext context, title) {
    // var document = parse(title);
    // var imgList = document.querySelectorAll("img");

    // for (dom.Element img in imgList) {
    //   print(img.attributes["src"]);
    //   print(img.toString());
    // }
    // return HTML.toRichText(context, title,
    //     defaultTextStyle: TextStyle(overflow: TextOverflow.ellipsis),
    //     linksCallback: (dynamic link) {
    //   CommonUtils().urlLauncher(url: link.toString());
    // });

    /// sanitize or query document here
    Widget html = Html(
        data: title,
        onLinkTap: (String? url, RenderContext context,
            Map<String, String> attributes, dom.Element? element) {
          CommonUtils().urlLauncher(url: url.toString());
        },
        style: {
          "body": Style(
              padding: 0.ph,
              color: Theme.of(context).textTheme.displayMedium!.color),
          // tables will have the below background color
        });
    return html;
  }
}
