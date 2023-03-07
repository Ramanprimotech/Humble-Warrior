import 'package:flutter/material.dart';

class TapHandler extends StatelessWidget {
  const TapHandler({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: child,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      overlayColor: MaterialStateProperty.resolveWith(
            (_) => Colors.transparent,
      ),
    );
  }
}