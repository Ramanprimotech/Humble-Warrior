import 'package:humble_warrior/modals/response/brands_response_mdel.dart';
import 'package:humble_warrior/network/api_call.dart';

import 'package:humble_warrior/hw.dart';

class BrandsController extends GetxController {
  Future<List<BrandDetails>> allBrands() async {
    return await CallAPI.allBrands();
  }
}
