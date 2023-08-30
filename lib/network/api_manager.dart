import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'custome_exception.dart';
import 'endpoints.dart';

class APIManager {
  Future<dynamic> getAllCall({required String url}) async {
    Uri urlForPost = Uri.parse("${Endpoints.baseUrl}$url");
    log("$urlForPost", name: "Executed POST API");
    var responseJson;
    try {
      final response = await http.get(urlForPost,
          headers: {'Authorization': 'Bearer ${Endpoints.token}'});
      responseJson = _response(response);
      // log("$responseJson", name: "Response API $url ");
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e, st) {
      log("$st", name: "Error API $url", error: e);
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> postAllCallNonParam({required String url}) async {
    Uri urlForPost = Uri.parse("${Endpoints.baseUrl}$url");
    log("$urlForPost", name: "Executed POST API");
    var responseJson;
    try {
      final response = await http.post(urlForPost,
          headers: {'Authorization': 'Bearer ${Endpoints.token}'});

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e, st) {
      log("$st", name: "Error API $url", error: e);
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> postAPICall({required String url, required var param}) async {
    Uri urlForPost = Uri.parse("${Endpoints.baseUrl}$url");
    log("$urlForPost", name: "Executed POST API");
    var responseJson;
    try {
      final response = await http.post(urlForPost,
          headers: {
            'Content-type': "application/json",
            'Authorization': 'Bearer ${Endpoints.token}'
          },
          body: jsonEncode(param.toJson()));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on Error catch (e, st) {
      log("$st", name: "Error API $url", error: e);
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> postAPICallNoBearer(
      {required String url, required var param, String? baseUrl}) async {
    Uri urlForPost = Uri.parse("${baseUrl ?? Endpoints.baseUrl}$url");
    log("$urlForPost", name: "Executed POST API");
    var responseJson;
    try {
      final response = await http.post(urlForPost,
          headers: {
            'Content-type': "application/json",
            // 'Authorization': 'Bearer ${Endpoints.token}'
          },
          body:  jsonEncode(param.toJson()));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on Error catch (e, st) {
      log("$st", name: "Error API $url", error: e);
      rethrow;
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw FetchDataException(
            'Internal Server Error with StatusCode: ${response.statusCode}');

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}
