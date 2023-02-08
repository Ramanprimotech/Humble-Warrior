import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_icons.dart';

import '../../utils/app_text.dart';

class ItemCard extends StatelessWidget {
  final double? cardHeight;
  final double imageHeight;
  final double imageTitleHeight;
  final double buttonbarHeight;
  final Widget? buttons;
  final double radius;
  final String imageUrl;
  final String title;

  const ItemCard(
      {Key? key,
      this.buttons,
      this.buttonbarHeight = 40,
      this.radius = 15,
      this.imageHeight = 180,
      this.imageTitleHeight = 60,
      this.cardHeight,
      required this.imageUrl,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageHeight + buttonbarHeight,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: const [BoxShadow(blurRadius: 4, spreadRadius: 0)]),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: imageHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(radius),
                    topLeft: Radius.circular(radius),
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: Get.width,
                  height: imageTitleHeight,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.only(
                    //     bottomRight: Radius.circular(15),
                    //     bottomLeft: Radius.circular(15)),
                    gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppText(
                      title,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: buttonbarHeight, child: buttons)
        ],
      ),
    );
  }
}

Widget codeButton({required String code}) {
  return InkWell(
    onTap: () {},
    child: Container(
        alignment: Alignment.center,
        width: 90,
        height: 28,
        decoration: BoxDecoration(color: Colors.blue),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIcons.cut(),
            AppText(
              color: Colors.white,
              code,
              fontSize: 14,
            ),
          ],
        )),
  );
}

Widget shareButton() {
  return InkWell(
    onTap: () {},
    child: Container(
        alignment: Alignment.center,
        width: 90,
        height: 28,
        decoration: BoxDecoration(color: Colors.pink),
        child: AppText(
          color: Colors.white,
          "Shop Now",
          fontSize: 14,
        )),
  );
}
