import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';
import 'package:humble_warrior/utils/common/photo_viewer.dart';

class FavouriteDeals extends StatelessWidget with CommonAppBar {
  const FavouriteDeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccountOptionTheme accountOptionTheme =
        Theme.of(Get.context!).extension<AccountOptionTheme>()!;
    FavouriteDealController controller = Get.find();
    ProductDetailsResponse donnaFavouriteDetails = Get.arguments[0];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CommonWidgets.titleBar(context,
                title: "Product Details", fontSize: 20, backIcon: true),
            Expanded(
              child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  children: [
                    favouritePageCard(
                        height: 160 + 50,
                        imageUrl: donnaFavouriteDetails.url!,
                        onTap: () {
                          if (!donnaFavouriteDetails.url.isEmptyOrNull) {
                            Get.to(CustomPhotoViewer(
                                url: donnaFavouriteDetails.url!));
                          }
                        }),
                    Container(
                      margin: 10.pv,
                      padding: 7.pv,
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10)),
                      child: AppText(
                        "${donnaFavouriteDetails.itemName!}",
                        color: Colors.white,
                        textAlign: TextAlign.left,
                        fontWeight: FontWeight.bold,
                        padding: 5.pl,
                        maxLines: 2,
                        fontSize: 18,
                      ).px4(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      width: MediaQuery.of(Get.context!).size.width * .9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.lorem,
                            style: TextStyle(
                                fontSize: 15,
                                color: accountOptionTheme.textColor),
                          ),
                          _buyNow(title: 'Mobile App here'),
                          _buyNow(title: 'Standard View'),
                          _buyNow(title: 'Standard View'),
                        ],
                      ),
                    ),
                  ]),
            )
            // .px(20).py(10),
          ],
        ),
      ),
    );
  }

  Widget _buyNow({title}) {
    return Padding(
      padding: 10.ph,
      child: Row(
        children: [
          AppText("$title ------->", fontSize: 14),
          10.swb,
          Container(
            margin: 10.pv,
            padding: 8.ph,
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10)),
            child: const AppText(
              buyNowTxt,
              color: Colors.white,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

favouritePageCard({double? height, onTap, imageUrl}) {
  return InkWell(
    onTap: onTap ?? () {},
    child: SizedBox(
      height: height ?? 220,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CommonWidgets.networkImage(
          imageUrl: imageUrl ?? "",
          alignment: Alignment.center,
          width: Get.width,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
