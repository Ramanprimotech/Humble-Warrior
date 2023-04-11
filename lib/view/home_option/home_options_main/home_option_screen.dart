import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/view/home_option/tab_screens/front_page_deals.dart';

class HomeOptionScreen extends GetView<HomeOptionController> {
  HomeOptionScreen({Key? key}) : super(key: key);

  final int data = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    const double tabFontSize = 18;

    final HomeOptionController controller = Get.find();
    controller.selectedIndex.value = data;
    return Scaffold(
      bottomNavigationBar: bottomNavigationWidget(context),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        titleSpacing: 5,
        leadingWidth: 35,
        centerTitle: false,
        title:
    Obx(
          () =>
           SearchBar(
            /// Uncomment this line to filter by category
            postType: controller.postType(controller.selectedIndex.value),
          ),

        ),
        leading: AppIcons.IosBackIcon(),
        actions: const [
          FilterIcon(
            // postType: controller.postType(controller.selectedIndex.value),
            postType: "",
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: TabBar(
              padding: 0.pt,
              isScrollable: true,
              controller: controller.tabController,
              tabs: <Widget>[
                AppText(
                  donnaDailyDealTxt.upperCamelCase,
                  fontSize: tabFontSize,
                ),
                AppText(donnaFrontPageDealTxt.upperCamelCase,
                    fontSize: tabFontSize),
                AppText(donnaFavouriteDealTxt.upperCamelCase,
                    fontSize: tabFontSize),
              ]),
        ),
      ),
      body: Padding(
        padding: 10.pt,
        child: TabBarView(
          controller: controller.tabController,
          children: const [
            DonnaDailyDeals(),
            FrontPageDeals(),
            DonnaFavourite(),
          ],
        ),
      ),
    );
  }
}
