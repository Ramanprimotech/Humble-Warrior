import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/requests/id_model.dart';
import 'package:humble_warrior/network/api_manager.dart';

import 'model.dart';

class FetchSearchList {
  var data = [];
  String fetchUrl = " ";
  List<ItemDetails> results = [];

  Future<List<ItemDetails>> getSearchList() async {
    var url = Uri.parse("${Endpoints.baseUrl}${Endpoints.donnaFavourite}");
    var response = await http.get(
      url,
      headers: {
        'Content-type': "application/json",
        'Authorization': 'Bearer ${Endpoints.token}'
      },
    );
    try {
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data.map((e) => ItemDetails.fromJson(e)).toList();
        print("Result ${results.toString()}");
      } else {
        print(response.statusCode.toString());
      }
    } on Exception catch (e) {
      print(e);
    }
    return results;
  }

  /// Product Details

  Future<List<ProDetailItem>> productDetails(String id) async {
    try {
      IdModel payload = IdModel(id: id);
      var response = await APIManager()
          .postAPICall(url: Endpoints.productDetails, param: payload);

      SingleProductDetailsResponse productDetailsApiResponse =
          SingleProductDetailsResponse.fromJson(response);

      if (response == null) {
        return [];
      }
      if (productDetailsApiResponse.status == true) {
        return productDetailsApiResponse.data!;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
