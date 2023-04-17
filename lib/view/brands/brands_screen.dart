import 'package:humble_warrior/hw.dart';

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
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
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
                  4.swb,
                  const Icon(Icons.search, size: 20),
                  4.swb,
                  SizedBox(
                    width: Get.width * .6,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: searchTextController,
                      decoration: const InputDecoration.collapsed(
                        hintText: searchTxt,
                        hintStyle: TextStyle(fontWeight: FontWeight.w400,color: Colors.black, fontSize: 16)
                      ),
                    ),
                  ),
                  20.swb,
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationWidget(context),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                            checkInternet: true,
                            context: context);
                      }),
                ),
              ),
            ]),
      ),
    );
  }
}
