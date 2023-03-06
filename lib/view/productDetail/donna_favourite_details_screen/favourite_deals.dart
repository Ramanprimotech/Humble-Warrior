import 'package:humble_warrior/modals/response/product_details_response.dart';
import 'package:humble_warrior/hw.dart';

class FavouriteDeals extends StatelessWidget with CommonAppBar {
  const FavouriteDeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccountOptionTheme accountOptionTheme =
        Theme.of(Get.context!).extension<AccountOptionTheme>()!;
    FavouriteDealController controller = Get.find();
    ProductDetailsResponse donnaFavouriteDetails = Get.arguments[0];
    return Scaffold(
      appBar: AppBarWidget(
        showBackButton: true,
        title: CustomSearchBar(
          focusNode: controller.focusNode,
          textEditingController: controller.searchTextController,
        ),
      ),
      body: Container(
        padding: 20.pa,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            favouritePageCard(
              height: 250,
              imageUrl: donnaFavouriteDetails.url!,
            ),
            /*SizedBox(
              height: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CommonWidgets.networkImage(
                  imageUrl: donnaFavouriteDetails.url!,
                  alignment: Alignment.topCenter,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),*/
            Container(
              margin: 10.pv,
              padding: 7.pv,
              width: Get.width,
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10)),
              child: AppText(
                donnaFavouriteDetails.itemName!,
                color: Colors.white,
                textAlign: TextAlign.left,
                fontWeight: FontWeight.bold,
                padding: 5.pl,
                maxLines: 2,
                fontSize: 18,
              ),
            ),
            Container(
              padding: 15.pv,
              width: MediaQuery.of(Get.context!).size.width * .9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.lorem,
                    style: TextStyle(
                        fontSize: 15, color: accountOptionTheme.textColor),
                  )
                ],
              ),
            ),
            _buyNow(title: 'Mobile App here'),
            _buyNow(title: 'Standard View'),
          ]),
        ),
      ),
    );
  }

  Widget _buyNow({title}) {
    return Row(
      children: [
        AppText("${title} ------->"),
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
    );
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
}
