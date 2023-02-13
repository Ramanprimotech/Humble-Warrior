import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:readmore/readmore.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final AboutScreenController controller = Get.put(AboutScreenController());
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 20, right: 10, left: 10),
        child: SingleChildScrollView(
          child: Column(children: [
            _aboutButton(),
            _showImg(),
            _details(),
            _seeCopyButton(),
            _brandRow(),
            _brandList(),
          ]),
        ),
      ),
    );
  }

  _aboutButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      width: MediaQuery.of(Get.context!).size.width,
      decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3),
            )
          ]),
      child: const AppText(aboutDonnaTxt,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          textAlign: TextAlign.center),
    );
  }

  _showImg() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.network(
        "https://humblewarrior.com/wp-content/uploads/2022/11/Facetune_20-06-2022-06-51-2.jpg",
        fit: BoxFit.fitWidth,
        height: 200,
        alignment: Alignment.topCenter,
        width: Get.width,
      ),
    );
  }

  _details() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
      width: MediaQuery.of(Get.context!).size.width,
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3),
            )
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppText('HELLO GORGEOUS!',
            fontWeight: FontWeight.bold, color: Colors.grey.shade800),
        const ReadMoreText(
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
          trimLines: 10,
          trimMode: TrimMode.Line,
          trimCollapsedText: "read more",
          trimExpandedText: "read less",
          lessStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
          moreStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ]),
    );
  }

  _seeCopyButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      width: MediaQuery.of(Get.context!).size.width,
      decoration: BoxDecoration(
          color: Colors.blueAccent.shade100,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3),
            )
          ]),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          const TextSpan(
            text: seeCopyHumbleTxt,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          WidgetSpan(child: 10.sw),
          const TextSpan(
              text: hereTxt,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 16))
        ]),
      ),
    );
  }

  _brandRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const AppText(
                "BRAND'S I",
                fontSize: 18,
              ),
              AppIcons.heart(
                iconColor: Colors.red,
              ),
            ],
          ),
          const AppText(
            "View All",
            fontSize: 16,
          ),
        ],
      ),
    );
  }

  _brandList() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 80,
      width: Get.height,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 25,
          itemBuilder: (ctx, index) {
            return SizedBox(
              height: 80,
              width: 100,
              child: Column(
                children: [
                  Image.network(
                    "https://seeklogo.com/images/A/adidas-logo-107B082DA0-seeklogo.com.png",
                    fit: BoxFit.fill,
                    height: 60,
                    width: 80,
                  ),
                  const Text(
                    "Product",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
