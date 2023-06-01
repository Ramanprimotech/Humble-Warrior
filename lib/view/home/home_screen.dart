import 'package:humble_warrior/hw.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = Get.find();
    final HomeScreenWidgets homeScreenWidgets =
        HomeScreenWidgets(controller: controller, context: context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        /// App Bar
        appBar: homeScreenWidgets.appBar(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 22.shb,

            ///Home Screen Categories List
            homeScreenWidgets.productCategoryListAPIBuilder(),
            4.shb,

            ///Home Option List Future Builder
            homeScreenWidgets.homeOptionDeals(),

            /// Brand List Future Builder
            homeScreenWidgets.brandListAPIBuilder(waitingState: true),
          ],
        ),
      ),
    );
  }
}
