import 'package:flutter/material.dart';

class MediaQueryText extends StatefulWidget {
   MediaQueryText({Key? key ,required this.child}) : super(key: key);
Widget child;

  @override
  State<MediaQueryText> createState() => _MediaQueryTextState();
}

class _MediaQueryTextState extends State<MediaQueryText> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(data: MediaQueryData(
      textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0),
    ), child: widget.child);
  }
}
