import 'package:humble_warrior/hw.dart';

class BrandsController extends GetxController {
  Future<List<BrandDetails>> allBrands() async {
    return await CallAPI.allBrands();
  }
}
