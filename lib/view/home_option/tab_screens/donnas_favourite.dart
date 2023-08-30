import 'package:humble_warrior/hw.dart';

class DonnaFavourite extends StatelessWidget {
  const DonnaFavourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeOptionController controller = Get.find();
    controller.context = context;
    FToast().init(context);
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
                child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
                return const CustomShimmer.rectangular(
                  height: 290,
                  borderRadius: 15,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                );
              },
              itemCount: 10,
              separatorBuilder: (BuildContext context, int index) {
                return 18.shb;
              },
            ));
          }
          if (controller.donnaFavouriteDealList.isEmpty &&
              controller.donnaFavouriteDealsBool.value == false) {
            return CommonWidgets.noData(
                update: controller.update,
                context: context,
                onTap: () {
                  controller.donnaFavouriteDealsBool.value = true;
                  controller.update();
                  controller.donnaFavouriteDealsAPI();
                });
          }
          return ListView.separated(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 6),
            controller: controller.donnaFavouriteDealScrollController,
            itemCount: controller.donnaFavouriteDealList.length + 1,
            itemBuilder: (ctx, index) {
              ProductDetailsResponse details = ProductDetailsResponse();
              if (index < controller.donnaFavouriteDealList.length) {
                details = controller.donnaFavouriteDealList[index];
              }
              return index < controller.donnaFavouriteDealList.length
                  ?
              /*CardView(
                index: index,
                details: details,
                onTap: () {
                  Get.toNamed(AppRoutes.frontPageProductDetail,
                      arguments: [details]);
                },
                cardText: details.ribbonName,
                imageText: true,
                imgUrl: details.url!,
                title: details.ribbonName != null
                    ? details.ribbonName!
                    : details.itemName.toString(),
              )*/
              favouritePageCard(
                      onTap: () {
                        Get.toNamed(AppRoutes.categoryItemDetail,id: 3,
                            arguments: { "details" : details});
                      },
                      imageUrl: details.url!,
                cardText: details.itemName,
                    )
                  : Obx(
                      () => Visibility(
                          visible: controller.donnaFavouriteDealsBool.value,
                          child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator())),
                    );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 18,
              );
            },
          );
        },
      ),
    );
  }

  favouritePageCard({double? height, onTap, imageUrl, String? cardText}) {
    return InkWell(
      onTap: onTap ?? () {},
      child: SizedBox(
        // height: height ?? 160 + 50,
        height: Get.width - 40,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CommonWidgets.networkImage(
                imageUrl: imageUrl ?? "",
                alignment: Alignment.topCenter,
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: cardText != ""
                  ? Container(
                  alignment: Alignment.bottomCenter,
                  height: 70,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                      gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black54,
                            Colors.black
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: AppText(
                    cardText??"",
                    padding: 8.pa,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ))
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
