import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:humble_warrior/utils/shimmer/shimmer_loader.dart';

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
      placeholder: (context, url) => ShimmerLoader(
        child: Container(
          color: Colors.grey,
          height: height,
          width: width,
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
