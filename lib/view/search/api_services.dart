import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/requests/pagination_modal.dart';
import 'package:humble_warrior/network/api_manager.dart';

import 'model.dart';

class FetchSearchList {
  var data = [];
  String fetchUrl = " ";
  List<SearchPosts> results = [];

  // Future<List<ItemDetails>> getSearchList() async {
  //   var url = Uri.parse("${Endpoints.baseUrl}${Endpoints.donnaFavourite}");
  //   var response = await http.get(
  //     url,
  //     headers: {
  //       'Content-type': "application/json",
  //       'Authorization': 'Bearer ${Endpoints.token}'
  //     },
  //   );
  //   try {
  //     if (response.statusCode == 200) {
  //       data = json.decode(response.body);
  //       results = data.map((e) => ItemDetails.fromJson(e)).toList();
  //       print("Result ${results.toString()}");
  //     } else {
  //       print(response.statusCode.toString());
  //     }
  //   } on Exception catch (e) {
  //     print(e);
  //   }
  //   return results;
  // }

  /// Product Details

  Future<List<SearchPosts>> productDetails(String id, String postType) async {
    try {
      // IdModel payload = IdModel(id: id);
      PaginationModel payload =
          PaginationModel(search: id, page: "1", postType: postType);
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
