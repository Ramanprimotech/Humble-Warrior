import 'package:humble_warrior/hw.dart';

class ProductDetailController extends GetxController {
  Future<List<ProductDetailsResponse>> productDetailsAPI(
      {required String idData}) async {
    return await CallAPI.productDetails(idData);
  }
}
