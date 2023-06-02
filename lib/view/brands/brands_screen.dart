import 'package:humble_warrior/hw.dart';

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({Key? key}) : super(key: key);

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  TextEditingController searchTextController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool showCross = false;
  bool searchIconVisibility = true;

  @override
  void initState() {
    // focusNode.requestFocus();
    // focusNode.addListener(() {
    //   if (focusNode.hasFocus) {
        searchIconVisibility = true;
    //   } else {
    //     searchIconVisibility = false;
    //   }
    // });
    super.initState();
  }

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
        leading: AppIcons.IosBackIcon(onPress: (){Get.back(id:3);}),
        title: Padding(
          padding: 15.pr,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Container(
              height: 45,
              width: double.infinity,
              // padding: 8.pa,
              // margin: 0.pa,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1,
                    color: Theme.of(context).textTheme.displaySmall!.color!),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  /*Image.asset(
                    !isDark
                        ? ImagePathAssets.hwLogoUnnamed
                        : ImagePathAssets.hwLogoUnnamedDark,
                    height: 40,
                    width: 40,
                  ),*/
                  12.swb,
                  //  if(searchIconVisibility==true)
                  //    const Icon(
                  //      Icons.search,
                  //    ),
                  //  /*Visibility(
                  //    visible: searchIconVisibility,
                  //    child: const Icon(
                  //     Icons.search,
                  // ),
                  //  ),*/
                  // 4.swb,
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.isEmpty &&
                            searchTextController.text == "") {
                          showCross = false;
                          searchIconVisibility = true;
                          focusNode.hasFocus;
                          setState(() {});
                        } else {
                          showCross = true;
                          searchIconVisibility = false;
                          focusNode.unfocus();
                          setState(() {});
                        }
                        setState(() {});
                      },
                      onFieldSubmitted: (value){
                        setState(() {
                          searchIconVisibility = false;
                        showCross = true;
                        focusNode.unfocus();
                        });
                      },
                      controller: searchTextController,
                      decoration:  InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 13),
                        hintText: searchTxt,
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Theme.of(context).textTheme.displayLarge!.color!,
                        ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide.none),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide.none),
                        suffixIcon: Visibility(
                          visible: showCross,
                          child: GestureDetector(
                            child: Icon(
                              Icons.close,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .color,
                              size: 20.sp,
                            ),
                            onTap: () {
                              searchTextController.clear();
                              showCross = false;
                              searchIconVisibility = false;
                              setState(() {});
                            },
                          ),
                        ),
                        // hintText: searchTxt,
                        // hintStyle: TextStyle(
                        //   fontWeight: FontWeight.w400,
                        //   fontSize: 15,
                        //   color: Theme.of(context).textTheme.displayLarge!.color!,
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: bottomNavigationWidget(context),
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
                        return RefreshIndicator(
                          onRefresh: (){
                              controller.update([Endpoints.allBrands]);
                           return Future.value(true);
                          },
                          child: FutureWidget<List<BrandDetails>>().builder(
                              futureWidgets:  BrandAPIWidgets(
                                  context: context,
                                  searchText: searchTextController.text),
                              future: controller.allBrands(),
                              checkInternet: true,
                              context: context),
                        );
                      }),
                ),
              ),
            ]),
      ),
    );
  }
}
