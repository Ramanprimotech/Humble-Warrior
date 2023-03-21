import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/response/brands_response_mdel.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeScreenController homeScreenController = Get.find();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 5,
        leadingWidth: 34,
        centerTitle: false,
        leading: AppIcons.IosBackIcon(),
        title: const SearchBar(),
        actions: [
          IconButton(
              padding: 16.pr,
              onPressed: () {
                // Get.toNamed(AppRoutes.sortPages);
              },
              icon: AppIcons.filter(size: 35))
        ],
      ),
      bottomNavigationBar: bottomNavigationWidget(context),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // CommonWidgets.titleBar(context,
              //     title: "$brandsTxt I", icon: true, fontSize: 20),
              Expanded(
                child: Container(
                  padding: 20.ph,
                  color: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor,
                  height: Get.height,
                  width: Get.height,
                  child: GetBuilder<HomeScreenController>(
                      id: Endpoints.allBrands,
                      init: homeScreenController,
                      builder: (controller) {
                        return FutureWidget<List<BrandDetails>>().builder(
                            futureWidgets: BrandAPIWidgets(context: context),
                            future: controller.allBrands(),
                            context: context);
                      }),
                ),
              ),
            ]),
      ),
    );
  }
}
