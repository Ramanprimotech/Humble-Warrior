import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/utils/common/html.dart';
import 'package:humble_warrior/utils/common/photo_viewer.dart';
import 'package:humble_warrior/view/static_pages/static_page_controller.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AboutScreenController aboutScreenController = Get.find();
    final HomeScreenController controller = Get.find();
    final StaticPagesController staticController =
        Get.find<StaticPagesController>();
    return Scaffold(
      // bottomNavigationBar: bottomNavigationWidget(context),
      body: SafeArea(
        child: FutureBuilder<List<StaticData>>(
          future: staticController.staticPageApi("40424"),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  /// About Donna title
                  CommonWidgets.titleBar(context,
                      backIcon: true, title: aboutDonnaTxt, fontSize: 18,onPress: (){
                    Get.back(id: 4);
                      }),
                  Expanded(
                    child: ListView(
                      // physics: const NeverScrollableScrollPhysics(),
                      children: [
                        CustomShimmer.rectangular(
                            height: 380, borderRadius: 15, margin: 16.pa),
                        const CustomShimmer.rectangular(
                            height: 20,
                            borderRadius: 15,
                            margin: EdgeInsets.only(
                                right: 150, left: 16, bottom: 12)),
                        const CustomShimmer.rectangular(
                            height: 16,
                            borderRadius: 15,
                            margin: EdgeInsets.only(
                                right: 16, left: 16, bottom: 8)),
                        const CustomShimmer.rectangular(
                            height: 16,
                            borderRadius: 15,
                            margin: EdgeInsets.only(
                                right: 16, left: 16, bottom: 8)),
                        const CustomShimmer.rectangular(
                            height: 16,
                            borderRadius: 15,
                            margin: EdgeInsets.only(
                                right: 16, left: 16, bottom: 8)),
                        const CustomShimmer.rectangular(
                          height: 16,
                          borderRadius: 15,
                          margin:
                              EdgeInsets.only(right: 16, left: 16, bottom: 8),
                        ),
                        const CustomShimmer.rectangular(
                          height: 16,
                          borderRadius: 15,
                          margin:
                              EdgeInsets.only(right: 16, left: 16, bottom: 8),
                        ),
                        const CustomShimmer.rectangular(
                          height: 16,
                          borderRadius: 15,
                          margin:
                              EdgeInsets.only(right: 16, left: 16, bottom: 8),
                        ),
                        const CustomShimmer.rectangular(
                          height: 16,
                          borderRadius: 15,
                          margin:
                              EdgeInsets.only(right: 16, left: 16, bottom: 8),
                        ),
                        CustomShimmer.rectangular(
                          height: 180,
                          borderRadius: 15,
                          margin: 16.pa,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return CommonWidgets.errorAPI(
                  errorText: "${snapshot.error}",
                  context: context,
                  onPress: () {
                    Get.back();
                  },
                  buttonTitle: "hjwerf");
            }
            List<StaticData> staticResponse = snapshot.data!;
            return staticResponse.isNotEmpty
                ? Column(
                    children: [
                      /// About Donna title
                      CommonWidgets.titleBar(
                        context,
                        backIcon: true,
                        title: aboutDonnaTxt,
                        fontSize: 18,
                        onPress: (){
                          Get.back(id: 4);
                        }
                      ),
                      Expanded(
                        child: ListView(children: [
                          /// About image
                          _showImg(staticResponse),

                          /// About Less
                          Obx(
                            () => Visibility(
                              key: const Key("less"),
                              visible: aboutScreenController.readMore.value,
                              child: _detailsLess(context, staticResponse),
                            ),
                          ),

                          /// About Details
                          Obx(
                            () => Visibility(
                              key: const Key("more"),
                              visible: !aboutScreenController.readMore.value,
                              child: _details(context, staticResponse),
                            ),
                          ),

                          ///About Donna Bottom Image
                          _showImgBottom(staticResponse),

                          /// See copy of humble warrior button
                          15.shb,
                          _seeCopyButton(),
                          25.shb,
                        ]),
                      ),

                      /// Brands List
                      HomeScreenWidgets(
                              context: context, controller: controller)
                          .brandListAPIBuilder(waitingState: true),
                    ],
                  )
                : Center(
                    child: CommonWidgets.errorAPI(
                        errorText: "Something went wrong",
                        context: context,
                        onPress: () {
                          Get.back();
                        },
                        buttonTitle: okTxt));
          },
        ),
      ),
    );
  }

  /// About Donna image
  _showImg(staticResponse) {
    return Padding(
      padding: 20.ph,
      child: GestureDetector(
        onTap: () {
          Get.to(
              CustomPhotoViewer(url: staticResponse[0].pageImage.toString()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CommonWidgets.networkImage(
            imageUrl: staticResponse[0].pageImage.toString(),
            fit: BoxFit.cover,
            height: 380,
            alignment: Alignment.topCenter,
            width: Get.width,
          ),
        ),
      ),
    );
  }

  /// About DonnaBottom image
  _showImgBottom(List<StaticData> staticResponse) {
    return Padding(
      padding: 20.ph,
      child: GestureDetector(
        onTap: () {
          Get.to(CustomPhotoViewer(
              url: staticResponse[0].page_bottom_image.toString()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CommonWidgets.networkImage(
            imageUrl: staticResponse[0].page_bottom_image.toString(),
            fit: BoxFit.fill,
            height: 170,
            alignment: Alignment.topCenter,
            width: Get.width,
          ),
        ),
      ),
    );
  }

  /// About Details
  _details(context, staticResponse) {
    final AboutScreenController aboutScreenController = Get.find();
    return Container(
      padding: 10.pa,
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      width: Get.width,
      decoration: CustomBoxDecorations(context: context).shadow(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const AppText(helloGorgeousTxt, fontWeight: FontWeight.bold),
        HtmlData()
            .htmlString(context, staticResponse[0].pageContent.toString()),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                aboutScreenController.readStatus();
              },
              child: const AppText(
                "Read Less",
                color: AppColors.blue,
              ),
            )
          ],
        )
      ]),
    );
  }

  /// About DetailsLess
  _detailsLess(context, List<StaticData> staticResponse) {
    final AboutScreenController aboutScreenController = Get.find();
    return Container(
      padding: 10.pa,
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      width: Get.width,
      decoration: CustomBoxDecorations(context: context).shadow(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const AppText(helloGorgeousTxt, fontWeight: FontWeight.bold),
        HtmlData().htmlString(
            context, staticResponse[0].page_less_content.toString()),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                aboutScreenController.readStatus();
              },
              child: const AppText(
                "Read More",
                color: AppColors.blue,
              ),
            )
          ],
        )
      ]),
    );
  }

  /// See copy of humble warrior button
  _seeCopyButton() {
    return Container(
      margin: 20.ph,
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
          WidgetSpan(child: 10.swb),
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await CommonUtils().urlLauncher(
                      url: Endpoints.pdf, title: theHumbleWarriorLowerTxt);
                },
              text: hereTxt,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 16))
        ]),
      ),
    );
  }
}
