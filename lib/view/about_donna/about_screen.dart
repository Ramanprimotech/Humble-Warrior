import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:humble_warrior/utils/search_bar/search_bar_ui.dart';
import 'package:humble_warrior/view/home/home_controller.dart';
import 'package:humble_warrior/view/home/home_screen_widgets.dart';
import 'package:readmore/readmore.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = Get.find();
    // final AboutScreenController controller = Get.put(AboutScreenController());
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 20,
        leading: Padding(
          padding: EdgeInsets.only(left: 15),
          child: GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios)),
        ),
        title: CustomSearchBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              child: Column(children: [
                _aboutButton(),
                _showImg(),
                _details(),
                _seeCopyButton(),
                const SizedBox(
                  height: 15,
                ),

              ]),
            ),
            HomeScreenWidgets(context: context, controller: controller)
                .brandsList(),
            const SizedBox(
              height: 25,
            ),
          ],
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 1,
              blurRadius: 1,
              // offset: const Offset(0, 3),
            )
          ]),
      child: AppText(aboutDonnaTxt,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: AppColors.primary,
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 1,
              blurRadius: 1,
              // offset: const Offset(0, 3),
            )
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppText(helloGorgeousTxt,
            fontWeight: FontWeight.bold, color: Colors.grey.shade800),
        const ReadMoreText(
          style: TextStyle(color: Colors.black),
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
          trimLines: 10,
          trimMode: TrimMode.Line,
          trimCollapsedText: readMoreTxt,
          trimExpandedText: readLessTxt,
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(Get.context!).size.width,
      decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 1,
              blurRadius: 1,
              // offset: const Offset(0, 3),
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

}
