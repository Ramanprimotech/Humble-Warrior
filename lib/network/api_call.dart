import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:humble_warrior/hw.dart';

class CallAPI {
  static Future<TokenResponseModel> generateToken(
      {required TokenRequestModel payload}) async {
    try {
      final response = await APIManager()
          .postAPICallNoBearer(url: Endpoints.generateToken, param: payload);
      var tokenResponseModel = TokenResponseModel.fromJson(response);
      return tokenResponseModel;
    } catch (e) {
      log(e.toString());
      return TokenResponseModel();
    }
  }

  static Future verifyToken({required double payload}) async {
    try {
      dynamic response = await APIManager()
          .postAPICall(url: Endpoints.verifyToken, param: payload);
      if (response == null) {
        return false;
      }
      if (response['status'] == 1) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  ///  Product List API
  static Future<ProductListResponse> productListAPI(
      {required PaginationModel payload, required String url}) async {
    try {
      var response = await APIManager().postAPICall(url: url, param: payload);
      ProductListResponse productListResponse =
          ProductListResponse.fromJson(response);
      if (response == null) {
        return ProductListResponse(data: []);
      }
      if (productListResponse.status == true) {
        return productListResponse;
      }
      return ProductListResponse(data: []);
    } catch (e) {
      return ProductListResponse(data: []);
    }
  }

  static Future<ProductListResponse> donnaDeals(
      {required PaginationModel payload}) async {
    try {
      var response = await APIManager()
          .postAPICall(url: Endpoints.donnaDeals, param: payload);

      ProductListResponse donnaDealsResponseModal =
          ProductListResponse.fromJson(response);
      if (response == null) {
        return ProductListResponse(data: []);
      }
      if (donnaDealsResponseModal.status == true) {
        return donnaDealsResponseModal;
      }
      return ProductListResponse(data: []);
    } catch (e) {
      return ProductListResponse(data: []);
    }
  }

  static Future<FrontPageResponseModel> frontPage(
      {required PaginationModel payload}) async {
    try {
      var response = await APIManager()
          .postAPICall(url: Endpoints.frontPage, param: payload);

      FrontPageResponseModel frontPageResponseModel =
          FrontPageResponseModel.fromJson(response);
      if (response == null) {
        return FrontPageResponseModel(data: []);
      }
      if (frontPageResponseModel.status == true) {
        return frontPageResponseModel;
      }
      return FrontPageResponseModel(data: []);
    } catch (e) {
      return FrontPageResponseModel(data: []);
    }
  }

  static Future<DonnaFavouriteResponseModel> donnaFavourite(
      {required PaginationModel payload}) async {
    try {
      var response = await APIManager()
          .postAPICall(url: Endpoints.donnaFavourite, param: payload);

      DonnaFavouriteResponseModel donnaFavouriteResponseModel =
          DonnaFavouriteResponseModel.fromJson(response);
      if (response == null) {
        return DonnaFavouriteResponseModel(data: []);
      }
      if (donnaFavouriteResponseModel.status == true) {
        return donnaFavouriteResponseModel;
      }
      return DonnaFavouriteResponseModel(data: []);
    } catch (e) {
      return DonnaFavouriteResponseModel(data: []);
    }
  }

  static Future<List<BrandDetails>> allBrands() async {
    try {
      var response =
          await APIManager().postAllCallNonParam(url: Endpoints.allBrands);
      BrandsResponseModel brandsResponseModel =
          BrandsResponseModel.fromJson(response);
      if (response == null) {
        return [];
      }
      if (brandsResponseModel.status == true) {
        return brandsResponseModel.data!;
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<ProductCategoryItem>> productCategoryAPI() async {
    try {
      var response = await APIManager()
          .postAllCallNonParam(url: Endpoints.productCategories);

      ProductCategoriesResponse productCategoriesResponse =
          ProductCategoriesResponse.fromJson(response);
      if (response == null) {
        return [];
      }

      if (productCategoriesResponse.status == true) {
        return productCategoriesResponse.data!;
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<HomeCategoryList>> homeCategory() async {
    try {
      var response =
          await APIManager().postAllCallNonParam(url: Endpoints.homeCategories);
      HomeCategoryResponseModel homeCategoryResponseModel =
          HomeCategoryResponseModel.fromJson(response);
      if (response == null) {
        return [];
      }
      if (homeCategoryResponseModel.status == true) {
        return homeCategoryResponseModel.data!;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<StaticData>> staticPages(
      {required dynamic payload}) async {
    try {
      dynamic response = await APIManager()
          .postAPICall(url: Endpoints.staticPages, param: payload);

      StaticPagesResponse staticPagesResponse =
          StaticPagesResponse.fromJson(response);
      log(staticPagesResponse.status.toString(), name: "static page");
      if (staticPagesResponse.status == true) {
        log(staticPagesResponse.data![0].pageContent.toString(), name: "Help");
      }
      return staticPagesResponse.data!;
    } catch (e) {
      return [];
    }
  }

  /// Product Details

  static Future<List<ProductDetailsResponse>> productDetails(String id) async {
    try {
      IdModel payload = IdModel(id: id);
      var response = await APIManager()
          .postAPICall(url: Endpoints.productDetails, param: payload);

      ProductDetailsApiResponse productDetailsApiResponse =
          ProductDetailsApiResponse.fromJson(response);
      if (response == null) {
        return [];
      }
      if (productDetailsApiResponse.status == true) {
        return productDetailsApiResponse.data!;
      }
      return [];
    } catch (e) {
      log("$e", name: "Details");
      rethrow;
    }
  }

  static Future authDataAPI({required Map payload}) async {
    try {
      final response = await http.post(
          Uri.parse("${Endpoints.baseUrl}${Endpoints.registerUser}"),
          body: payload);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        await SharePreferenceData.addStringToSF(
            spRegisterUserId, "${data['user_id']}");
      }

      return;
    } catch (e) {
      log(e.toString());
      return;
    }
  }

  ///  Notification List API
  static Future<NotificationResponseModel> notificationListAPI(
      {required Map payload}) async {
    log(payload.toString(), name: "Notification Delete");
    try {
      final response = await http.post(
          Uri.parse("${Endpoints.baseUrl}${Endpoints.notificationList}"),
          body: payload);
      NotificationResponseModel notificationResponseModel =
          NotificationResponseModel(posts: []);
      if (response.statusCode == 200) {
        notificationResponseModel =
            NotificationResponseModel.fromJson(jsonDecode(response.body));
      }
      if (response == null) {
        return notificationResponseModel;
      }
      return notificationResponseModel;
    } catch (e) {
      return NotificationResponseModel(posts: []);
    }
  }

  ///  Notification Status API
  static Future<bool> notificationStatusAPI({required Map payload}) async {
    try {
      final response = await http.post(
          Uri.parse("${Endpoints.baseUrl}${Endpoints.notificationList}"),
          body: payload);
      if (response.statusCode == 200) {
        return true;
      }
      if (response == null) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Delete Notification Status API
  static Future<bool> deleteNotification({required Map payload}) async {
    log(payload.toString(), name: "Notification Delete");
    try {
      final response = await http.post(
          Uri.parse("${Endpoints.baseUrl}${Endpoints.deleteNotificationList}"),
          body: payload,
      headers: {'Authorization': 'Bearer ${Endpoints.token}'});

      if (jsonDecode(response.body)['status'] ==  true) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
