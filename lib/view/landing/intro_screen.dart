import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/image_path_network.dart';
import '../../utils/routes/app_routes.dart';
import 'intro_controller.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final IntroScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  PageView(
                    onPageChanged: (index) {
                      controller.currentIndex.value = index;
                    },
                    controller: controller.pageController,
                    children: [
                      introOne(),
                      introTwo(),
                      introThree(),
                      introFour(),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: Obx(
                      () => Visibility(
                        visible: controller.currentIndex.value != 3,
                        child: TextButton(
                          onPressed: () {
                            controller.pageController.jumpToBottom();
                          },
                          child: "Skip"
                              .text
                              .size(28)
                              .black
                              .fontWeight(FontWeight.w400)
                              .make(),
                        ),
                      ),
                    ),
                  ).positioned(top: 5, right: 5),
                ],
              ),
            ),
            Transform.scale(
                scale: .6,
                child: SmoothPageIndicator(
                  count: 4,
                  effect: const WormEffect(
                    activeDotColor: AppColors.purple,
                    dotColor: AppColors.lightPurple,
                  ),
                  onDotClicked: (index) {},
                  controller: controller.pageController,
                )),
            Obx(
              () => Container(
                alignment: Alignment.center,
                height: 60,
                child: controller.currentIndex.value != 3
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          controller.currentIndex.value != 0
                              ? IconButton(
                                  iconSize: 30,
                                  onPressed: () {
                                    print("dfghjk");
                                    controller.currentIndex.value =
                                        controller.currentIndex.value - 1;
                                    controller.pageController.previousPage(
                                        duration: const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut);
                                  },
                                  icon: const Icon(Icons.arrow_back),
                                )
                              : const SizedBox(
                                  height: 20,
                                ),
                          IconButton(
                            iconSize: 30,
                            onPressed: () {
                              print("dfghjk");
                              controller.pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ],
                      ).py(8)
                    : SizedBox(
                        height: 60,
                        width: 80,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.loginPage);
                          },
                          child: "Next".text.make(),
                        ),
                        // CommonUtils.button(title: "Next", function: () {
                        //   Get.toNamed(AppRoutes.landing);
                        // }),
                      ),
              ).py(16),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget introOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Image.network(
              ImagePathNetwork.insight,
              height: 60,
              width: 100,
            ),
            Positioned(
              top: 15,
              left: 15,
              right: 15,
              child: Image.network(
                ImagePathNetwork.image2,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        "From Five Star".text.size(12).make(),
        "To No Star".text.size(12).make(),
        const SizedBox(
          height: 8,
        ),
        "The best choices to select from".text.gray400.make(),
        "supplimenting all your needs".text.gray400.make(),
        // "".text.gray400.make(),
      ],
    );
  }

  Widget introTwo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          ImagePathNetwork.insight,
          height: 60,
          width: 100,
          fit: BoxFit.fill,
        ),
        const SizedBox(
          height: 25,
        ),
        "Fast And".text.size(12).make(),
        "Easy".text.size(12).make(),
        const SizedBox(
          height: 8,
        ),
        "Your dream destination is just".text.gray400.make(),
        "a few clicks away".text.gray400.make(),
      ],
    );
  }

  Widget introThree() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          ImagePathNetwork.insight,
          height: 60,
          width: 100,
          fit: BoxFit.fill,
        ),
        const SizedBox(
          height: 25,
        ),
        "Need a Good".text.size(12).make(),
        "Buy?".text.size(12).make(),
        const SizedBox(
          height: 8,
        ),
        "It's the first and best platform to".text.gray400.make(),
        "BID for a better BARGIN".text.gray400.make(),
      ],
    );
  }

  Widget introFour() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          ImagePathNetwork.image2,
          height: 60,
          width: 100,
          fit: BoxFit.fill,
        ),
        const SizedBox(
          height: 25,
        ),
        "Need a Customized".text.size(12).make(),
        "Offer?".text.size(12).make(),
        const SizedBox(
          height: 8,
        ),
        "Tell us what you need. Let the hotels".text.gray400.make(),
        "offer you the best price".text.gray400.make(),
      ],
    );
  }
}
