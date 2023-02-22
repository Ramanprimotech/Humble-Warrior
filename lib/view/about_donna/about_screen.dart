import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:humble_warrior/utils/search_bar/search_bar_ui.dart';
import 'package:humble_warrior/view/home/home_controller.dart';
import 'package:humble_warrior/view/home/home_screen_widgets.dart';
import 'package:readmore/readmore.dart';

import '../../utils/decorations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = Get.find();
    return Scaffold(
      appBar: CustomAppBar(
        title: CustomSearchBar(
          textEditingController: TextEditingController(),
          focusNode: FocusNode(),
        ),
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: 15.ph,
              child: Container(
                margin: 10.pv,
                child: Column(children: [
                  _aboutButton(context),
                  _showImg(),
                  _details(context),
                  _seeCopyButton(),
                  const SizedBox(
                    height: 15,
                  ),
                ]),
              ),
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

  _aboutButton(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      width: MediaQuery.of(Get.context!).size.width,
      decoration: CustomBoxDecorations().shadow(context: context),
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

  _details(context) {
    return Container(
      padding: 10.pa,
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
      width: Get.width,
      decoration: CustomBoxDecorations().shadow(context: context),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const AppText(helloGorgeousTxt, fontWeight: FontWeight.bold),
        ReadMoreText(
          style: Theme.of(context).textTheme.bodyMedium,
          AppStrings.lorem,
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
