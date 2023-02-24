import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/image_path_network.dart';
import 'intro_controller.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final IntroScreenController controller = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            50.sh,
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: humbleWarriorTxt,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 34,
                  )),
              WidgetSpan(
                child: Transform.translate(
                  offset: const Offset(8.0, -20.0),
                  child: Text(
                    tmTxt,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ])),
            // AppText("The Humble Warrior",fontSize: 36,color: Colors.grey.shade600),
            const AppText(fashionLifestyleTxt,
                fontSize: 16, color: Colors.black),
            30.sh,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _title(text: lookGoodTxt),
                5.sw,
                Icon(
                  Icons.favorite,
                  color: Colors.pinkAccent.shade100,
                ),
                5.sw,
                _title(text: feelGoodTxt),
                5.sw,
                Icon(
                  Icons.favorite,
                  color: Colors.pinkAccent.shade100,
                ),
                5.sw,
                _title(text: doGoodTxt),
              ],
            ),
            // AppText("Look Good ❤ Feel Good ❤ Do Good",fontSize: TextSizes.large,color: Colors.pinkAccent),
            Container(
              height: 400,
              margin: 20.ps,
              padding: const EdgeInsets.only(
                  top: 40, bottom: 10, left: 20, right: 20),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 10,
                    spreadRadius: 2)
              ]),
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      onPageChanged: (index) {
                        controller.currentIndex.value = index;
                      },
                      controller: controller.pageController,
                      children: [
                        _image(imgUrl: ImagePathNetwork.insight),
                        _image(imgUrl: ImagePathNetwork.insight),
                        _image(imgUrl: ImagePathNetwork.insight),
                        //introFour(),
                      ],
                    ),
                  ),
                  40.sh,
                  Transform.scale(
                      scale: .6,
                      child: SmoothPageIndicator(
                        count: 3,
                        effect: WormEffect(
                          activeDotColor: Colors.black,
                          dotColor: Colors.grey.shade600,
                        ),
                        onDotClicked: (index) {},
                        controller: controller.pageController,
                      )),
                  Obx(() => Container(
                      alignment: Alignment.center,
                      // height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          controller.currentIndex.value != 2
                              ? TextButton(
                                  onPressed: () {
                                    controller.skipFunc();
                                  },
                                  child: const AppText(
                                    skipTxt,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ))
                              : const SizedBox(),
                          TextButton(
                              onPressed: () {
                                controller.currentIndex.value != 2
                                    ? controller.nextFunc()
                                    : controller.startFunc();
                              },
                              child: AppText(
                                controller.currentIndex.value != 2
                                    ? nextTxt
                                    : startTxt,
                                color: Colors.black,
                                fontSize: 18,
                              )),
                        ],
                      ))),
                  10.sh,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _image({imgUrl}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Image.network(
            imgUrl,
          ),
        ),
      ],
    );
  }

  _title({text}) {
    return AppText(text, color: Colors.pinkAccent.shade100, fontSize: 18);
  }
}
