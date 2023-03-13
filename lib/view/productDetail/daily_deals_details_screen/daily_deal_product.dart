import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';

import '../../../hw.dart';

class DailyDealProduct extends StatelessWidget with ProductDetailWidget {
  DailyDealProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DailyDealProductController controller = Get.find();
    final ProductDetailsResponse donnaDealsDetails = Get.arguments[0];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CommonWidgets.titleBar(context,
                title: "Product Details", fontSize: 20, backIcon: true),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20),
                      child: donnaDealsCard(donnaDealsDetails, 0, context,
                          isDetails: true),
                    ),
                    productText(context, donnaDealsDetails.itemName.toString()),
                    productDescription(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
