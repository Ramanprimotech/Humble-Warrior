import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/view/home_option/tab_screens/front_page_deals.dart';

class HomeOptionScreen extends GetView<HomeOptionController> {
  const HomeOptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FToast().init(context);
    const double tabFontSize = 18;
    final HomeOptionController controller = Get.find();
    controller.context = context;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 5,
        leadingWidth: 35,
        centerTitle: false,
        title: const SearchBar(),
        leading: AppIcons.IosBackIcon(),
        bottom: TabBar(
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
        actions: [
          IconButton(
              padding: 16.pr,
              onPressed: () {
                Get.toNamed(AppRoutes.sortPages);
              },
              icon: AppIcons.filter(size: 35))
        ],
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
