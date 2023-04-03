import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/response/brands_response_mdel.dart';

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({Key? key}) : super(key: key);

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  TextEditingController searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    HomeScreenController homeScreenController = Get.find();
    final ThemeController themeController = Get.find();

    bool isDark = themeController.themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 5,
        leadingWidth: 34,
        centerTitle: false,
        leading: AppIcons.IosBackIcon(),
        title: Padding(
          padding: 15.pr,
          child: Container(
            height: 45,
            width: double.infinity,
            padding: 8.pa,
            margin: 0.pa,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: Theme.of(context).textTheme.displaySmall!.color!),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Image.asset(
                  !isDark
                      ? ImagePathAssets.hwLogoUnnamed
                      : ImagePathAssets.hwLogoUnnamedDark,
                  height: 40,
                  width: 40,
                ),
                const Spacer(),
                // const Icon(Icons.search, size: 20),
                SizedBox(
                  width: Get.width * .6,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: searchTextController,
                    decoration: const InputDecoration.collapsed(
                      hintText: "Search Brand",
                    ),
                  ),
                ),
                20.swb,
              ],
            ),
          ),
        ),
        // actions: [
        //   IconButton(
        //       padding: 16.pr,
        //       onPressed: () {
        //         // Get.toNamed(AppRoutes.sortPages);
        //       },
        //       icon: AppIcons.filter(size: 35))
        // ],
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
                            futureWidgets: BrandAPIWidgets(
                                context: context,
                                searchText: searchTextController.text),
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
