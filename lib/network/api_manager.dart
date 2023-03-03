import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'custome_exception.dart';
import 'endpoints.dart';

class APIManager {
  Future<dynamic> getAllCall({required String url}) async {
    debugPrint("Calling API: $url");
    Uri urlForPost = Uri.parse("${Endpoints.baseUrl}$url");
    var responseJson;
    try {
      final response = await http.get(urlForPost,
          headers: {'Authorization': 'Bearer ${Endpoints.token}'});
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAllCallNonParam({required String url}) async {
    debugPrint("Calling API: $url");
    Uri urlForPost = Uri.parse("${Endpoints.baseUrl}$url");
    var responseJson;
    try {
      final response = await http.post(urlForPost,
          headers: {'Authorization': 'Bearer ${Endpoints.token}'});

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAPICall({required String url, required var param}) async {
    debugPrint("Calling API: $url");
    debugPrint("Calling parameters: $param");

    Uri urlForPost = Uri.parse("${Endpoints.baseUrl}$url");
    var responseJson;
    try {
      final response = await http.post(urlForPost,
          headers: {
            'Content-type': "application/json",
            'Authorization': 'Bearer ${Endpoints.token}'
          },
          body: jsonEncode(param.toJson()));
      // log(response.body);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on Error catch (e) {
      debugPrint('Error: $e');
    }
    return responseJson;
  }

  Future<dynamic> postAPICallNoBearer(
      {required String url, required var param}) async {
    debugPrint("Calling API: $url");
    debugPrint("Calling parameters: $param");

    Uri urlForPost = Uri.parse("${Endpoints.baseUrl}$url");
    var responseJson;
    try {
      final response = await http.post(urlForPost,
          headers: {
            'Content-type': "application/json",
            // 'Authorization': 'Bearer ${Endpoints.token}'
          },
          body: jsonEncode(param.toJson()));
      log(response.body);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on Error catch (e) {
      print('Error: $e');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    debugPrint("${response.statusCode}");
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
