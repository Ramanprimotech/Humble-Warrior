import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/utils/common/html.dart';
import 'package:humble_warrior/utils/common/photo_viewer.dart';
import 'package:humble_warrior/view/productDetail/product_detail_controller.dart';

class FavouriteDeals extends StatelessWidget with CommonAppBar {
  const FavouriteDeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccountOptionTheme accountOptionTheme =
        Theme.of(Get.context!).extension<AccountOptionTheme>()!;
    ProductDetailController controller = Get.find();
    ProductDetailsResponse donnaFavouriteDetails = Get.arguments[0];
    Future<List<ProductDetailsResponse>> _futureInstance = controller
        .productDetailsAPI(idData: donnaFavouriteDetails.id.toString());
    return Scaffold(
      bottomNavigationBar: bottomNavigationWidget(context),
      body: SafeArea(
        child: Column(
          children: [
            CommonWidgets.titleBar(context,
                title: "Product Details", fontSize: 20, backIcon: true),
            FutureBuilder<List<ProductDetailsResponse>>(
                future: _futureInstance,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      child: ShimmerLoader(
                        child: Column(
                          children: [
                            Container(
                              width: Get.width,
                              height: Get.width - 40,
                              decoration: CustomBoxDecorations()
                                  .shadow(context: context),
                            ),
                            Container(
                              margin: 10.pv,
                              padding: 7.pv,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: AppText(
                                "",
                                color: Colors.white,
                                textAlign: TextAlign.left,
                                fontWeight: FontWeight.bold,
                                padding: 5.pl,
                                maxLines: 2,
                                fontSize: 18,
                              ).px4(),
                            ),
                          ],
                        ).px(16),
                      ),
                    );
                  }
                  if (snapshot.hasError || snapshot.data!.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: AppText("Something Went Wrong"),
                      ),
                    );
                  }
                  ProductDetailsResponse data = snapshot.data![0];
                  return Expanded(
                    child: ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        children: [
                          favouritePageCard(
                              height: Get.width - 40,
                              imageUrl: data.url!,
                              onTap: () {
                                if (!data.url.isEmptyOrNull) {
                                  Get.to(CustomPhotoViewer(url: data.url!));
                                }
                              }),
                          Visibility(
                            visible:
                                data.itemName != null && data.itemName != "",
                            child: Container(
                              margin: 10.pv,
                              padding: 7.pv,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: AppText(
                                data.itemName!,
                                color: Colors.white,
                                textAlign: TextAlign.left,
                                fontWeight: FontWeight.bold,
                                padding: 5.pl,
                                maxLines: 2,
                                fontSize: 18,
                              ).px4(),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            width: MediaQuery.of(Get.context!).size.width * .9,
                            child: HtmlData()
                                .htmlString(context, data.productDescription),
                            /*Text(
                              data.productDescription ?? "",
                              maxLines: 100,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: accountOptionTheme.textColor),
                            ),*/
                          ),
                        ]),
                  );
                }),
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
