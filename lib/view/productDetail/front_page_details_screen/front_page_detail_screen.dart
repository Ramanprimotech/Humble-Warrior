import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';
import 'package:humble_warrior/view/productDetail/product_detail_controller.dart';

import '../../../hw.dart';
import '../../home_option/tab_screens/front_page_deals.dart';

class FrontPageDetailScreen extends StatelessWidget with ProductDetailWidget {
  FrontPageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductDetailsResponse details = Get.arguments[0];
    ProductDetailController controller = Get.find();
    Future<List<ProductDetailsResponse>> _futureInstance =
        controller.productDetailsAPI(idData: details.id.toString());

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
                            padding: 8.ph,
                            child: frontPageCard(data, 0, context,
                                isDetails: true),
                          ),
                          productText(context, data.itemName),
                          productDescription(
                            context: context,
                              itemName: data.itemName,
                              discription: data.productDescription),
                        ],
                      ).px(10),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
