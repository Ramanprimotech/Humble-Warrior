import 'package:humble_warrior/hw.dart';

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
              if (index != controller.donnaFavouriteDealList.length) {
                details = controller.donnaFavouriteDealList[index];
              }
              return index != controller.donnaFavouriteDealList.length
                  ? favouritePageCard(
                      onTap: () {
                        Get.toNamed(AppRoutes.favouriteDeal,
                            arguments: [details]);
                      },
                      imageUrl: details.url!,
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

  favouritePageCard({double? height, onTap, imageUrl}) {
    return InkWell(
      onTap: onTap ?? () {},
      child: SizedBox(
        // height: height ?? 160 + 50,
        height: Get.width - 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CommonWidgets.networkImage(
            imageUrl: imageUrl ?? "",
            alignment: Alignment.topCenter,
            width: Get.width,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
