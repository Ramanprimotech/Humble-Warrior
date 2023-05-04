import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/utils/common/html.dart';
import 'package:humble_warrior/view/static_pages/static_page_controller.dart';

class StaticPagesScreen extends StatelessWidget {
  const StaticPagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StaticPagesController controller = Get.find<StaticPagesController>();
    // controller.ids = Get.arguments[0];
    // String title = Get.arguments[1];
    controller.ids = "40427";
    String title = termsConditionsTxt;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          CommonWidgets.titleBar(context, title: title, fontSize: 20,onPress: (){
            Get.back(id: 4);
          }),
          FutureBuilder<List<StaticData>>(
              future: controller.staticPageApi(controller.ids),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Center(
                        child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            CustomShimmer.rectangular(
                              height: 150,
                              borderRadius: 15,
                              margin: EdgeInsets.only(
                                  left: 15, right: 15, top: 5, bottom: 20),
                            ),
                            CustomShimmer.rectangular(
                              height: 30,
                              width: 250,
                              borderRadius: 8,
                              margin: EdgeInsets.symmetric(horizontal: 15),
                            ),
                          ],
                        );
                      },
                      itemCount: 10,
                      separatorBuilder: (BuildContext context, int index) {
                        return 5.shb;
                      },
                    )),
                  );
                }
                if (snapshot.hasError) {
                  return CommonWidgets.errorAPI(
                      errorText: somethingWentWrongTxt.toString(),
                      context: context,
                      onPress: () {
                        Get.back();
                      },
                      buttonTitle: okTxt);
                }

                List<StaticData> staticResponse = snapshot.data!;
                return staticResponse.isNotEmpty
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: HtmlData().htmlString(context,
                                staticResponse[0].pageContent.toString()),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Center(
                            child: CommonWidgets.errorAPI(
                                errorText: somethingWentWrongTxt.toString(),
                                context: context,
                                onPress: () {
                                  Get.back();
                                },
                                buttonTitle: okTxt)),
                      );
              }),
        ]),
      ),
    );
  }
}
