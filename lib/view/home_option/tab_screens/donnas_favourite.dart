import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/donna_favourite_response_model.dart';
import 'package:humble_warrior/utils/common/common_pagination.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';

import '../../../utils/routes/app_routes.dart';
import '../home_options_main/home_option_controller.dart';

class DonnaFavourite extends StatelessWidget {
  const DonnaFavourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeOptionController controller = Get.find();
    return PaginationWidget(
      api: controller.donnaFavouriteDealsAPI,
      apiBool: controller.donnaFavouriteDealsBool,
      scrollController: controller.donnaFavouriteDealScrollController,
      update: controller.update,
      totalRecords: controller.donnaFavouriteDealsTotalDeals,
      length: controller.donnaFavouriteDealListLength,
      child: GetBuilder<HomeOptionController>(
        init: controller,
        builder: (ctx) {
          if (controller.donnaFavouriteDealList.isEmpty &&
              controller.donnaFavouriteDealsBool.value == true) {
            return Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                CommonWidgets.loading(),
              ],
            ));
          }
          if (controller.donnaFavouriteDealList.isEmpty &&
              controller.donnaFavouriteDealsBool.value == false) {
            return CommonWidgets.noData();
          }
          return ListView.builder(
              controller: controller.donnaFavouriteDealScrollController,
              itemCount: controller.donnaFavouriteDealList.length + 1,
              itemBuilder: (ctx, index) {
                DonnaFavouriteDetails details = DonnaFavouriteDetails();
                if (index != controller.donnaFavouriteDealList.length) {
                  details = controller.donnaFavouriteDealList[index];
                }
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: index != controller.donnaFavouriteDealList.length
                      ? InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.favouriteDeal,
                                arguments: [details]);
                          },
                          child: SizedBox(
                            height: 220,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CommonWidgets.networkImage(
                                imageUrl: details.url!,
                                alignment: Alignment.center,
                                width: Get.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      // ItemCard(
                      //   onTap: (){
                      //       Get.toNamed(AppRoutes.favouriteDeal);
                      //   },
                      //         buttons: Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //           children: [
                      //             shopButton(
                      //                 url: controller
                      //                     .donnaFavouriteDealList[index].url),
                      //             // codeButton(code: ""),
                      //             shareButton(shareUrl: ImagePathNetwork.url),
                      //             IconButton(
                      //               onPressed: () {},
                      //               icon: AppIcons.bookmarks(),
                      //             ),
                      //           ],
                      //         ),
                      //         imageUrl: details.url!,
                      //         title: details.productName.toString(),
                      //       )
                      : Obx(
                          () => Visibility(
                              visible: controller.donnaFavouriteDealsBool.value,
                              child: Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator())),
                        ),
                );
              });
        },
      ),
    );

    // NotificationListener<ScrollNotification>(
    //   key: UniqueKey(),
    //   onNotification: (ScrollNotification scrollInfo) {
    //     if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
    //       // onLoadMore();
    //       print("object");
    //       if (controller.donnaFavouriteDealsBool.value == false) {
    //         controller.donnaFavouriteDealsBool.value = true;
    //         controller.update();
    //         Future.delayed(Duration(milliseconds: 10), () {
    //           controller.donnaFavouriteDealScrollController.animateTo(
    //             controller.donnaFavouriteDealScrollController.position
    //                 .maxScrollExtent,
    //             duration: Duration(milliseconds: 500),
    //             curve: Curves.fastOutSlowIn,
    //           );
    //         });
    //
    //         controller.donnaFavouriteDealsAPI();
    //       }
    //     }
    //     return true;
    //   },
    //   child: GetBuilder<HomeOptionController>(
    //     init: controller,
    //     builder: (ctx) {
    //       if (controller.donnaFavouriteDealList.isEmpty &&
    //           controller.donnaFavouriteDealsBool.value == true) {
    //         return Center(
    //             child: Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: const [
    //             CircularProgressIndicator(),
    //             AppText(
    //               " Loading Deals for you...",
    //               fontSize: 24,
    //               fontWeight: FontWeight.w700,
    //             ),
    //           ],
    //         ));
    //       }
    //       if (controller.donnaFavouriteDealList.isEmpty &&
    //           controller.donnaFavouriteDealsBool.value == false) {
    //         return const Center(
    //           child: AppText(
    //             "No Data Found",
    //             fontSize: 24,
    //             fontWeight: FontWeight.w700,
    //           ),
    //         );
    //       }
    //       return ListView.builder(
    //           controller: controller.donnaFavouriteDealScrollController,
    //           itemCount: controller.donnaFavouriteDealList.length + 1,
    //           itemBuilder: (ctx, index) {
    //             DonnaFavouriteDetails details = DonnaFavouriteDetails();
    //             if (index != controller.donnaFavouriteDealList.length) {
    //               details = controller.donnaFavouriteDealList[index];
    //             }
    //             return Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: index != controller.donnaFavouriteDealList.length
    //                   ? ItemCard(
    //                       buttons: Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                         children: [
    //                           shopButton(
    //                               url: controller
    //                                   .donnaFavouriteDealList[index].url),
    //                           // codeButton(code: ""),
    //                           shareButton(shareUrl: ImagePathNetwork.url),
    //                           IconButton(
    //                             onPressed: () {},
    //                             icon: AppIcons.bookmarks(),
    //                           ),
    //                         ],
    //                       ),
    //                       imageUrl: details.url!,
    //                       title: details.productName.toString(),
    //                     )
    //                   : Obx(
    //                       () => Visibility(
    //                           visible: controller.donnaFavouriteDealsBool.value,
    //                           child: Container(
    //                               height: 80,
    //                               alignment: Alignment.center,
    //                               child: CircularProgressIndicator())),
    //                     ),
    //             );
    //           });
    //     },
    //   ),
    // );

    //   ListView.builder(itemBuilder: (ctx, index) {
    //   return Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: ItemCard(
    //       buttons: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           shopButton(url: ImagePathNetwork.url),
    //           codeButton(code: "dklfgj"),
    //           shareButton(shareUrl: ImagePathNetwork.url),
    //           IconButton(
    //             onPressed: () {},
    //             icon: AppIcons.bookmarks(),
    //           ),
    //         ],
    //       ),
    //       imageUrl:
    //           "https://humblewarrior.com/wp-content/uploads/2022/11/ANRABESS-2022-Fall-Winter-Long-Sleeve-1-4-Zipper-Collared-Casual-Chunky-Cable-Knit-Cropped-Pullover-11-15-22-LIVE-PIC-SMC.jpg",
    //       title: 'Title Of Image',
    //     ),
    //   );
    // });
  }
}
