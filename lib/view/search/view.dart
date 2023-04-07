import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/view/filter/filter_controller.dart';
import 'package:humble_warrior/view/search/api_services.dart';
import 'package:humble_warrior/view/search/model.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  FocusNode focusNode = FocusNode();
  String postType = Get.arguments[0];
  String catId = Get.arguments[1];
  String name = Get.arguments[2];
  String image = Get.arguments[3];
  List<int> selectedCategories = [];
  RxBool showCross = false.obs;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    FilterController filterController = Get.find();
    filterController.postType = postType;
    filterController.catID = catId == "" ? null : int.parse(catId);
    if (filterController.catID != null) {
      if (!filterController.record.contains(ProductCategoryItem(
          id: int.parse(catId), categoryImage: image, categoryName: name))) {
        selectedCategories.add(int.parse(catId));
        filterController.record.add(ProductCategoryItem(
            id: int.parse(catId), categoryImage: image, categoryName: name));
        filterController.update();
      }
    }

    FToast().init(context);
    HiveService hiveService = Get.find();
    Box<RecentSearch> box = hiveService.recentBox;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 5,
        leadingWidth: 35,
        centerTitle: false,
        title: SearchBar(
          padding: 8.pv,
          child: TextFormField(
            focusNode: focusNode,
            controller: filterController.controller,
            onChanged: (value) {
              if (value.isEmpty) {
                showCross.value = false;
              } else {
                showCross.value = true;
              }
              // if (value.length >= 3) {
              //   hiveService.addToRecentList(
              //       RecentSearch(productSearched: controller.text));
              //   setState(() {});
              // }
              if (timer != null) {
                timer!.cancel();
              }

              timer = Timer(const Duration(seconds: 1), () {
                if (value.length >= 3) {
                  hiveService.recentFavourite(
                      item: RecentSearch(
                          productSearched:
                              filterController.controller.text));
                  // hiveService.addToRecentList(
                  //     RecentSearch(productSearched: filterController.controller.text));
                  setState(() {});
                }
              });
            },
            onFieldSubmitted: (value) {
              if (timer != null) {
                timer!.cancel();
              }
              if (value.length >= 3) {
                // hiveService.addToRecentList(
                //     RecentSearch(productSearched: controller.text));
                setState(() {});
              } else {
                DialogHelper.showToast(context, enterThreeTxt);
              }
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0).r,
              counterText: "",
              hintText: searchTxt,
              hintStyle: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .color
                      ?.withOpacity(0.6),
                  fontSize: 16),
              // AppText(searchTxt,
              //     fontWeight: FontWeight.w400, fontSize: 14, padding: 4.pl),
              // hintStyle:
              isDense: true,
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),

              /// prefixIcon
              prefixIcon: GestureDetector(
                // padding: 4.pl,
                onTap: () {
                  if (selectedCategories.isEmpty) {
                    if (filterController.controller.text.length >= 3) {
                      // hiveService.addToRecentList(RecentSearch(
                      //     productSearched: filterController.controller.text));
                      setState(() {});
                    } else {
                      focusNode.unfocus();
                      DialogHelper.showToast(context, enterThreeTxt);
                    }
                  } else {
                    setState(() {});
                  }
                },
                child: Icon(Icons.search,
                    color: Theme.of(context).textTheme.displayMedium!.color,
                    size: 24.sp),
              ),

              // suffixIcon:
              suffixIcon: Obx(
                () => Visibility(
                  visible: showCross.value,
                  child: GestureDetector(
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).textTheme.displayMedium!.color,
                      size: 20.sp,
                    ),
                    onTap: () {
                      filterController.controller.clear();
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        leading: AppIcons.IosBackIcon(),
        actions: [
          selectedCategories.isEmpty
              ? IconButton(
                  padding: 16.pr,
                  onPressed: () async {
                    var data = await Get.toNamed(
                      AppRoutes.filterView,
                    );
                    if (data != null) {
                      List<int> values = [];
                      data.forEach((e) => values.add(e.id!));
                      selectedCategories.clear();
                      selectedCategories.addAll(values);

                      setState(() {});
                    }
                  },
                  icon: AppIcons.filter(size: 35))
              : Badge(
                  alignment: const AlignmentDirectional(20.0, 3.0),
                  label: AppText(
                    "${selectedCategories.length}",
                    fontSize: 10,
                    color: Colors.white,
                  ),
                  child: IconButton(
                      padding: 16.pr,
                      onPressed: () async {
                        var data = await Get.toNamed(AppRoutes.filterView);
                        if (data != null) {
                          List<int> values = [];
                          data.forEach((e) => values.add(e.id!));
                          selectedCategories.clear();
                          selectedCategories.addAll(values);

                          setState(() {});
                        }
                      },
                      icon: AppIcons.filter(size: 35)),
                )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<SearchPosts>>(
                future: FetchSearchList().productDetails(
                    filterController.controller.text,
                    postType,
                    selectedCategories),
                builder: (ctx, snapshot) {
                  if (filterController.controller.text.isEmpty &&
                      selectedCategories.isEmpty) {
                    return ValueListenableBuilder(
                        valueListenable: box.listenable(),
                        builder: (context, value, child) {
                          Map<dynamic, RecentSearch> dataMap = box.toMap();
                          List<RecentSearch> data =
                              dataMap.values.toList().reversed.toList();
                          var dataKeys =
                              dataMap.keys.toList().reversed.toList();
                          if (box.isEmpty) {
                            return const Center(
                              child: AppText(
                                searchDealsTxt,
                                fontSize: 18,
                              ),
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppText(
                                recentTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ).paddingSymmetric(horizontal: 20, vertical: 20),
                              Expanded(
                                child: ListView.separated(
                                  itemCount: box.length > 8 ? 8 : box.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        filterController.controller.text =
                                            data[index].productSearched!;
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 40,
                                        padding: 10.ph,
                                        margin: 20.ph,
                                        decoration: CustomBoxDecorations(
                                                context: context)
                                            .shadow(),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Icon(Icons.history),
                                            AppText("${data[index].productSearched}")
                                                .paddingOnly(left: 10),
                                            const Spacer(),
                                            InkWell(
                                              child: const Icon(
                                                Icons.cancel_outlined,
                                              ),
                                              onTap: () {
                                                hiveService
                                                    .deleteRecentItemByKey(
                                                        dataKeys[index]);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 20,
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        });
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: AppText(
                        somethingWentWrongTxt,
                        maxLines: 4,
                      ),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: AppText(noDealsTxt),
                    );
                  }

                  return ListView.separated(
                      padding: 15.pv,
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return 10.shb;
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            // hiveService.recentFavourite(
                            //     item: RecentSearch(
                            //         productSearched:
                            //             filterController.controller.text));
                            Get.toNamed(AppRoutes.dailyDealProductDetail,
                                arguments: [
                                  ProductDetailsResponse(
                                      id: snapshot.data![index].id)
                                ]);
                          },
                          child: Container(
                            height: 80,
                            margin: 20.ph,
                            decoration:
                                CustomBoxDecorations(context: context).shadow(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                  child: CommonWidgets.networkImage(
                                      height: 80,
                                      width: Get.width * .3,
                                      imageUrl:
                                          snapshot.data![index].url.toString(),
                                      fit: BoxFit.cover),
                                ),
                                SizedBox(
                                  height: 80,
                                  width: Get.width * .7 - 40,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      (snapshot.data![index].categoryName ==
                                                  null ||
                                              snapshot.data![index]
                                                      .categoryName ==
                                                  "")
                                          ? const SizedBox()
                                          : Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 3),
                                              decoration: BoxDecoration(
                                                  color: AppColors.primary,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  )),
                                              child: AppText(
                                                snapshot
                                                    .data![index].categoryName!
                                                    .toUpperCase(),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                      SizedBox(
                                        width: Get.width * .7 - 40,
                                        child: AppText(
                                          snapshot.data![index].itemName
                                              .toString(),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          maxLines: 2,
                                        ).paddingSymmetric(
                                            horizontal: 8, vertical: 4),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );

                        //   ListTile(
                        //   onTap: () {},
                        //   contentPadding: 16.ph,
                        //   leading: Image.asset(
                        //     ImagePathAssets.hwLogoUnnamed,
                        //     height: 40,
                        //     width: 40,
                        //   ),
                        //   title:
                        //       AppText("${snapshot.data![index].productName}"),
                        // );
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
