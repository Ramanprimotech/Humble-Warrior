import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';
import 'package:humble_warrior/hw.dart';

class FetchSearchList {
  var data = [];
  String fetchUrl = " ";
  List<ItemDetails> results = [];

  Future<List<ItemDetails>> getSearchList() async {
    var url = Uri.parse("${Endpoints.baseUrl}${Endpoints.donnaFavourite}");
    var response = await http.get(url,
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
}
