import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/utils/common/html.dart';
import 'package:humble_warrior/view/productDetail/product_detail_controller.dart';

class CategoryItemDetail extends StatelessWidget with ProductDetailWidget {
  CategoryItemDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductDetailsResponse details = Get.arguments[0];
    ProductDetailController controller = Get.find();
    Future<List<ProductDetailsResponse>> _futureInstance =
        controller.productDetailsAPI(idData: details.id.toString());

    return Scaffold(
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 20),
                            child: categoryListCard(data, 0, context,
                                categoryCard: false, isDetails: true),
                          ),
                          productTitleDetail(context, data.itemName),
                          productDesc(data.productDescription,
                              context: context),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget productTitleDetail(context, title) {
    return Container(
      decoration: CustomBoxDecorations().shadow(context: context),
      width: MediaQuery.of(Get.context!).size.width * .9,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: AppText(
        "$title",
        fontWeight: FontWeight.bold,
        fontSize: 20,
        maxLines: 3,
      ),
    );
  }

  /// Product Description
  Widget productDesc(String? dis, {required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: MediaQuery.of(Get.context!).size.width * .9,
      child: HtmlData().htmlString(context, dis!),
      /* AppText(
        dis ?? "",
        fontSize: 16,
        maxLines: 150,
      ),*/
    );
  }
}
