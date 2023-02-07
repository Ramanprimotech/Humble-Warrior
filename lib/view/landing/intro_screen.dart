import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/image_path_network.dart';
import '../../utils/routes/app_routes.dart';
import '../../utils/sizes/enumClass.dart';
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
            SizedBox(height: 10,),
            AppText("The Humble Warrior",fontSize: TextSizes.extraLarge,color: Colors.black),
            SizedBox(height: 10,),
            AppText("Fashion and Lifestyle for women",fontSize: TextSizes.medium,color: Colors.black),
            SizedBox(height: 50,),
            AppText("Look Good ❤ Feel Good ❤ Do Good",fontSize: TextSizes.large,color: Colors.pinkAccent),
            SizedBox(height: 50,),
            Container(
              height:350,
              margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey.shade200,blurRadius: 10,spreadRadius: 2)]
              ),
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

                  SizedBox(height: 10,),
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
            Obx(
            () => Container(
                  alignment: Alignment.center,
                  height: 60,
                  child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            controller.currentIndex.value != 2?
                            TextButton(
                              onPressed: (){
                                controller.pageController.jumpToBottom();
                            }, child: AppText("Skip",color: Colors.black,fontSize: TextSizes.large,)
                            ):
                            SizedBox(),
                             /*IconButton(
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
                                  )*/
                               TextButton(onPressed: (){
                                 controller.pageController.nextPage(
                                     duration: const Duration(milliseconds: 500),
                                     curve: Curves.easeInOut);
                               },
                                   child: AppText("Next",color: Colors.black,fontSize: TextSizes.large,)),
                            /*IconButton(
                              iconSize: 30,
                              onPressed: () {
                                print("dfghjk");
                                controller.pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                              },
                              icon: const Icon(Icons.arrow_forward),
                            ),*/
                          ],
                        )
            )
            ),
            const SizedBox(
            height: 10,
            ),

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
            //ImagePathNetwork.insight,
            // height: 60,
            // width: 100,
          ),
        ),
        /*Stack(
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
        // "".text.gray400.make(),*/
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
        /*Image.network(
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
        "a few clicks away".text.gray400.make(),*/
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
        /*Image.network(
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
        "BID for a better BARGIN".text.gray400.make(),*/
      ],
    );
  }

/*  Widget introFour() {
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
  }*/
}
