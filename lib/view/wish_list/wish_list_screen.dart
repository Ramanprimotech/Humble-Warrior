import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';
import 'package:humble_warrior/modals/response/donna_deals_response.dart';
import 'package:humble_warrior/modals/response/donna_favourite_response_model.dart';
import 'package:humble_warrior/modals/response/front_page_response_model.dart';
import 'package:humble_warrior/view/wish_list/wish_list_widgets/wish_list_card_selector.dart';

class WishList extends StatelessWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WishListController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
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
      body: SafeArea(
        child: Column(
          children: [
            // CommonWidgets.titleBar(context,
            //     title: myWishlistTxt, fontSize: 20, backIcon: false),
            12.shb,
            Expanded(
              child: Obx(
                () => Center(
                    child: controller.loggedIn.value == false
                        ? loginFirst(context)
                        : CustomRefreshIndicator(
                            onRefresh: () async {
                              return Future.delayed(Duration(seconds: 1), () {
                                controller.getWishList();
                                return Future.value(0);
                              });
                            },
                            // child: ValueListenableBuilder(
                            //     valueListenable: box.listenable(),
                            //     builder: (context, value, child) {
                            //       var values = value.values.toList();
                            //       return values.isEmpty
                            //           ? const Center(
                            //               child: AppText(
                            //                 "No Item Added in Favourite",
                            //                 fontSize: 20,
                            //               ),
                            //             )
                            //           : ListView.separated(
                            //               itemCount: values.length,
                            //               itemBuilder:
                            //                   (BuildContext context, int index) {
                            //                 ProductDetailsResponse details =
                            //                     values[index];
                            //                 return Padding(
                            //                   padding: const EdgeInsets.only(
                            //                       left: 20, right: 20, bottom: 20),
                            //                   child: WishListCardSelector(
                            //                     details: details,
                            //                     index: index,
                            //                     context: context,
                            //                   ),
                            //                 );
                            //               },
                            //               separatorBuilder:
                            //                   (BuildContext context, int index) {
                            //                 return const SizedBox(
                            //                   height: 20,
                            //                 );
                            //               },
                            //             );
                            //     }),
                            child: Obx(
                              () => controller.data.value.isEmpty
                                  ? const Center(
                                      child: AppText(
                                        "No Item Added in Favourite",
                                        fontSize: 20,
                                      ),
                                    )
                                  : ListView.separated(
                                padding: 20.pb,
                                      itemCount: controller.data.value.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        ProductDetailsResponse details =
                                            controller.data.value[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                          ),
                                          child: WishListCardSelector(
                                            details: details,
                                            index: index,
                                            context: context,
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(
                                          height: 18,
                                        );
                                      },
                                    ),

                            ))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loginFirst(context) {
    return CommonWidgets.errorAPI(
        height: 150,
        buttonTitle: gotoLoginTxt,
        errorText: accessingMsgTxt,
        context: context,
        onPress: () {
          Get.offAllNamed(AppRoutes.loginPage);
        });
  }
}

modelReturn(int index) {
  int type = index % 3;

  if (type == 0) {
    return DonnaDealsDetails(
        url:
            "https://humblewarrior.com/wp-content/uploads/2023/02/Screenshot-2023-02-27-at-8.14.10-AM-300x300.png",
        shopUrl: "https://shop.humblewarrior.com/amazon/m36V",
        couponCode: "asdasdsdsd",
        dealName: "CAT CONDO SAVINGS!");
  }
  if (type == 1) {
    return DonnaFavouriteDetails(
      url:
          "https://humblewarrior.com/wp-content/uploads/2023/01/Table-Top-Fire-Pit-Bowl-01-12-23-LIVE-PIC-SMFT.jpg",
      productName: "Table-Top-Fire-Pit-Bowl",
    );
  }

  return FrontPageDetails(
      url:
          "https://humblewarrior.com/wp-content/uploads/2022/11/Screen-Shot-2022-11-19-at-7.40.27-PM-258x155.png",
      productName: "Vine Oh! for the Holidays!",
      ribbonColor: "FFFFFF",
      ribbonName: "Vine Oh! Ho Ho!");
}
