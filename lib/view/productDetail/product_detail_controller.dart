import 'package:get/get.dart';
import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';
import 'package:humble_warrior/network/api_call.dart';

class ProductDetailController extends GetxController {
  // RxList<ProductDetailsResponse> product = <ProductDetailsResponse>[].obs;

  Future<List<ProductDetailsResponse>> productDetailsAPI(
      {required String idData}) async {
    // log(paginationModel.toString(), name: "Sort");
    return await CallAPI.productDetails(idData);
  }
}
