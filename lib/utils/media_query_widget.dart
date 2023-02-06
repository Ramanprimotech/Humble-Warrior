import 'package:flutter/material.dart';

class MediaQueryWidget extends StatefulWidget {
  Widget child;
  MediaQueryWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<MediaQueryWidget> createState() => _MediaQueryWidgetState();
}

class _MediaQueryWidgetState extends State<MediaQueryWidget> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(textScaleFactor: 1),
      child: widget.child,
    );
  }
}
