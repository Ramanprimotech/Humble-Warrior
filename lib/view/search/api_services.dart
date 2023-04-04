import 'package:humble_warrior/hw.dart';

import 'model.dart';

class FetchSearchList {
  var data = [];
  String fetchUrl = " ";
  List<SearchPosts> results = [];

  /// Product Details

  Future<List<SearchPosts>> productDetails(
      String id, String postType, List<int> searchCat) async {
    try {
      PaginationModel payload = PaginationModel(
          search: id, page: "1", postType: postType, catIds: searchCat);
      payload.toString();
      var response =
          await APIManager().postAPICall(url: Endpoints.search, param: payload);

      SearchResponseModel searchResponseModel =
          SearchResponseModel.fromJson(response);

      if (response == null) {
        return [];
      }
      if (searchResponseModel.status == true) {
        return searchResponseModel.data!;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
