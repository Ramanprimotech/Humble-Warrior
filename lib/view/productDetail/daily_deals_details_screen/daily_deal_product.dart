import 'package:humble_warrior/utils/common/photo_viewer.dart';
import 'package:humble_warrior/view/productDetail/product_detail_controller.dart';

import '../../../hw.dart';

class DailyDealProduct extends StatelessWidget with ProductDetailWidget {
  DailyDealProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DailyDealProductController controller = Get.find();

    ProductDetailController productDetailController = Get.find();
    final ProductDetailsResponse donnaDealsDetails = Get.arguments[0];
    Future<List<ProductDetailsResponse>> _futureInstance =
        productDetailController.productDetailsAPI(
            idData: donnaDealsDetails.id.toString());
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: CardView(
                              details: data,
                              onTap: () {
                                if (data.url != "" || data.url != null) {
                                  Get.to(CustomPhotoViewer(url: data.url!));
                                }
                              },
                              imgUrl: data.url!,
                              title: data.itemName!,
                            ),
                            // donnaDealsCard(data, 0, context,
                            //     isDetails: true),
                          ),
                          productText(context, data.itemName.toString()),
                          productDescription(
                              context: context,
                              itemName: data.itemName.toString(),
                              discription: data.productDescription),
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
}
