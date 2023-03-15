import 'package:hive_flutter/hive_flutter.dart';
import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/hive_modal/recent_search_model.dart';
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

  @override
  Widget build(BuildContext context) {
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
                DialogHelper.showToast(
                    context, "Enter at least three characters");
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
                  if (controller.text.length >= 3) {
                    hiveService.addToRecentList(
                        RecentSearch(productSearched: controller.text));
                    setState(() {});
                  } else {
                    focusNode.unfocus();
                    DialogHelper.showToast(
                        context, "Enter at least three characters");
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
          IconButton(
            padding: 15.pr,
            onPressed: () {
              Get.toNamed(AppRoutes.sortPages);
            },
            icon: CircleAvatar(
              maxRadius: 20.r,
              backgroundColor: Colors.black26,
              child: Icon(Icons.tune,
                  color: Theme.of(context).textTheme.displayMedium!.color,
                  size: 22.sp),
            ),
          )
        ],
      ),
      body: SafeArea(
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
              child: FutureBuilder<List<ProDetailItem>>(
                future: FetchSearchList().productDetails(controller.text),
                builder: (ctx, snapshot) {
                  if (controller.text.length == 0) {
                    return ValueListenableBuilder(
                        valueListenable: box.listenable(),
                        builder: (context, value, child) {
                          var data = value.values.toList();
                          var dataKeys = value.keys.toList();
                          if (box.isEmpty) {
                            return const Center(
                              child: AppText(
                                "Search Deals...",
                                fontSize: 18,
                              ),
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppText(
                                "Recent",
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
                                        decoration: CustomBoxDecorations()
                                            .shadow(context: context),
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
                      child: AppText(snapshot.error.toString()),
                    );
                  }
                  if (snapshot.data == []) {
                    return const Center(
                      child: AppText("No Data found"),
                    );
                  }
                  if (snapshot.data![0].productName == null ||
                      snapshot.data![0].productName == "") {
                    return const Center(
                      child: AppText("No Data found"),
                    );
                  }

                  return ListView.separated(
                      padding: 15.pt,
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return 10.shb;
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 80,
                          margin: 20.ph,
                          decoration:
                              CustomBoxDecorations().shadow(context: context),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    AppText(
                                      snapshot.data![index].productName
                                          .toString(),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    AppText(
                                      snapshot.data![index].productDescription
                                          .toString(),
                                      fontSize: 14,
                                      maxLines: 2,
                                    ),
                                  ],
                                ).paddingSymmetric(horizontal: 8, vertical: 4),
                              ),
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                child: CommonWidgets.networkImage(
                                    height: 80,
                                    width: Get.width * .3,
                                    imageUrl:
                                        snapshot.data![index].url.toString(),
                                    fit: BoxFit.cover),
                              ),
                            ],
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
