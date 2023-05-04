import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/view/home_option/tab_screens/front_page_deals.dart';

class HomeOptionScreen extends GetView<HomeOptionController> {
  int data;
  HomeOptionScreen({required this.data ,Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    controller.selectedIndex.value = data;
    const double tabFontSize = 18;
    return Scaffold(
      // bottomNavigationBar: bottomNavigationWidget(context),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        titleSpacing: 5,
        leadingWidth: 35,
        centerTitle: false,
        title:
    Obx(
          () =>
           SearchBar(
             route: 3,
            /// Uncomment this line to filter by category
            postType: controller.postType(controller.selectedIndex.value),
          ),

        ),
        leading: AppIcons.IosBackIcon(onPress: (){
          Get.back(id: 3);
        }),
        actions: const [
          FilterIcon(
            route: 3,
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
