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
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  String postType = Get.arguments[0];
  String catId = Get.arguments[1];
  String name = Get.arguments[2];
  String image = Get.arguments[3];
  List<int> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    FilterController filterController = Get.find();
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
            controller: controller,
            onFieldSubmitted: (value) {
              if (value.length >= 3) {
                hiveService.addToRecentList(
                    RecentSearch(productSearched: controller.text));
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
                  fontSize: 14),
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
                    if (controller.text.length >= 3) {
                      hiveService.addToRecentList(
                          RecentSearch(productSearched: controller.text));
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
              suffixIcon: GestureDetector(
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).textTheme.displayMedium!.color,
                  size: 20.sp,
                ),
                onTap: () {
                  controller.clear();
                  setState(() {});
                },
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
                    var data = await Get.toNamed(AppRoutes.filterView);
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
      body:
          // SizedBox(
          //   width: double.infinity,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       const AppText(
          //         "Coming Soon...",
          //         fontWeight: FontWeight.bold,
          //         fontSize: 26,
          //       ),
          //       50.shb
          //     ],
          //   ),
          // )
          SafeArea(
        child: Column(
          children: [
            // Row(
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         Get.back();
            //       },
            //       child: Icon(Icons.arrow_back_ios,
            //               color:
            //                   Theme.of(context).textTheme.displayMedium!.color,
            //               size: 24.sp)
            //           .paddingOnly(left: 20),
            //     ),
            //     Expanded(
            //       child: SearchBar(
            //         padding: 8.pv,
            //         child: TextFormField(
            //           focusNode: focusNode,
            //           controller: controller,
            //           onFieldSubmitted: (value) {
            //             if (value.length >= 3) {
            //               hiveService.addToRecentList(
            //                   RecentSearch(productSearched: controller.text));
            //               setState(() {});
            //             } else {
            //               DialogHelper.showToast(
            //                   context, "Enter at least three characters");
            //             }
            //           },
            //           decoration: InputDecoration(
            //             contentPadding:
            //                 const EdgeInsets.symmetric(horizontal: 10.0).r,
            //             counterText: "",
            //             hintText: "Search HW",
            //             // hintStyle:
            //             isDense: true,
            //             focusedBorder: const UnderlineInputBorder(
            //               borderSide: BorderSide.none,
            //             ),
            //             enabledBorder: const UnderlineInputBorder(
            //               borderSide: BorderSide.none,
            //             ),
            //
            //             /// prefixIcon
            //             prefixIcon: IconButton(
            //               padding: 8.pl,
            //               onPressed: () {
            //                 if (controller.text.length >= 3) {
            //                   hiveService.addToRecentList(RecentSearch(
            //                       productSearched: controller.text));
            //                   setState(() {});
            //                 } else {
            //                   focusNode.unfocus();
            //                   DialogHelper.showToast(
            //                       context, "Enter at least three characters");
            //                 }
            //               },
            //               icon: Icon(Icons.search,
            //                   color: Theme.of(context)
            //                       .textTheme
            //                       .displayMedium!
            //                       .color,
            //                   size: 24.sp),
            //             ),
            //
            //             // suffixIcon:
            //             suffixIcon: GestureDetector(
            //               child: Icon(
            //                 Icons.close,
            //                 color: Theme.of(context)
            //                     .textTheme
            //                     .displayMedium!
            //                     .color,
            //                 size: 20.sp,
            //               ),
            //               onTap: () {
            //                 controller.clear();
            //                 setState(() {});
            //               },
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: 16.ph,
            //       child: InkWell(
            //         onTap: () {
            //           Get.toNamed(AppRoutes.sortPages);
            //         },
            //         child: CircleAvatar(
            //           maxRadius: 20.r,
            //           backgroundColor: Colors.black26,
            //           child: Icon(Icons.tune,
            //               color:
            //                   Theme.of(context).textTheme.displayMedium!.color,
            //               size: 22.sp),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // 16.shb,
            Expanded(
              child: FutureBuilder<List<SearchPosts>>(
                future: FetchSearchList().productDetails(
                    controller.text, postType, selectedCategories),
                builder: (ctx, snapshot) {
                  if (controller.text.isEmpty && selectedCategories.isEmpty) {
                    return ValueListenableBuilder(
                        valueListenable: box.listenable(),
                        builder: (context, value, child) {
                          var data = value.values.toList();
                          var dataKeys = value.keys.toList();
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
                                  itemCount: box.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        controller.text =
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
                                                    .deleteRecentSearchItem(
                                                        dataKeys[index]
                                                            .toString());
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
                    return Center(
                      child: AppText(
                        snapshot.error.toString(),
                        maxLines: 4,
                      ),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: AppText(noDealsTxt),
                    );
                  }
                  // if (snapshot.data![0].itemName == null ||
                  //     snapshot.data![0].itemName == "") {
                  //   return const Center(
                  //     child: AppText("No Deals found"),
                  //   );
                  // }

                  return ListView.separated(
                      padding: 15.pv,
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return 10.shb;
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
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
