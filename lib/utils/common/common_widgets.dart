import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommonWidgets {
  static Widget networkImage({
    required String imageUrl,
    double? height,
    double? width,
    BoxFit? fit,
    double scale = 1,
    Alignment? alignment,
  }) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: alignment ?? Alignment.center,
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) => Center(
          child: Transform.scale(
              scale: scale, child: CircularProgressIndicator())),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
