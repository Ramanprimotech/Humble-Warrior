import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:humble_warrior/hw.dart';

class HtmlData {
  htmlString(BuildContext context, title) {
    /// sanitize or query document here
    Widget html = MediaQueryWidget(
      child: Html(
          data: title,
          onLinkTap: (String? url, RenderContext context,
              Map<String, String> attributes, dom.Element? element) {
            CommonUtils().urlLauncher(url: url.toString());
          },
          style: {
            "body":
                Style(color: Theme.of(context).textTheme.displayMedium!.color),
          }),
    );
    return html;
  }
}
