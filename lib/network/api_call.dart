import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';
import 'package:humble_warrior/modals/requests/id_model.dart';
import 'package:humble_warrior/modals/response/brands_response_mdel.dart';
import 'package:humble_warrior/modals/response/donna_favourite_response_model.dart';
import 'package:humble_warrior/modals/response/front_page_response_model.dart';
import 'package:humble_warrior/modals/response/home_categories_response_model.dart';
import 'package:humble_warrior/modals/response/notification_response_model.dart';
import 'package:humble_warrior/modals/response/product_category_response.dart';
import 'package:humble_warrior/modals/response/product_details_api_response.dart';
import 'package:humble_warrior/modals/response/product_list_response.dart';
import 'package:humble_warrior/modals/response/static_page_model.dart';
import 'package:humble_warrior/modals/response/token_response.dart';

import '../modals/requests/pagination_modal.dart';
import '../modals/requests/token_model_request.dart';
import 'api_manager.dart';

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
      // payload.toString().logRequest(apiName: Endpoints.donnaDeals);

      var response = await APIManager().postAPICall(url: url, param: payload);
      debugPrint("Step 0");
      ProductListResponse productListResponse =
          ProductListResponse.fromJson(response);
      debugPrint("Step 1");
      if (response == null) {
        return ProductListResponse(data: []);
      }
      if (productListResponse.status == true) {
        return productListResponse;
      }
      return ProductListResponse(data: []);
    } catch (e) {
      log("API", name: "API Deals $url ${payload.page}", error: e);
      // Endpoints.donnaDeals.logError(apiName: Endpoints.donnaDeals, error: e);
      return ProductListResponse(data: []);
    }
  }

  static Future<ProductListResponse> donnaDeals(
      {required PaginationModel payload}) async {
    try {
      // payload.toString().logRequest(apiName: Endpoints.donnaDeals);

      var response = await APIManager()
          .postAPICall(url: Endpoints.donnaDeals, param: payload);

      ProductListResponse donnaDealsResponseModal =
          ProductListResponse.fromJson(response);

      //
      // log(response.toString(), name: "${Endpoints.donnaDeals}");
      // response.toString().logResponse(apiName: Endpoints.donnaDeals);
      if (response == null) {
        return ProductListResponse(data: []);
      }

      // DialogHelper.closeDialog();

      if (donnaDealsResponseModal.status == true) {
        // _userController.userModel = UserModel.fromMap(response['data']);
        // DialogHelper.showToast(Get.context!, response['msg']);
        return donnaDealsResponseModal;
      }
      // Endpoints.donnaDeals.logError( apiName : Endpoints.donnaDeals ,error: response);
      // DialogHelper.showErrorDialog(
      //   title: 'Error Updating',
      //   description: response['msg'],
      // );
      return ProductListResponse(data: []);
    } catch (e) {
      // Endpoints.donnaDeals.logError(apiName: Endpoints.donnaDeals, error: e);
      return ProductListResponse(data: []);
    }
  }

  static Future<FrontPageResponseModel> frontPage(
      {required PaginationModel payload}) async {
    try {
      // payload.toString().logRequest(apiName: Endpoints.donnaDeals);

      var response = await APIManager()
          .postAPICall(url: Endpoints.frontPage, param: payload);

      FrontPageResponseModel frontPageResponseModel =
          FrontPageResponseModel.fromJson(response);

      //
      // log(response.toString(), name: "${Endpoints.donnaDeals}");
      // response.toString().logResponse(apiName: Endpoints.donnaDeals);
      if (response == null) {
        return FrontPageResponseModel(data: []);
      }

      // DialogHelper.closeDialog();

      if (frontPageResponseModel.status == true) {
        // _userController.userModel = UserModel.fromMap(response['data']);
        // DialogHelper.showToast(Get.context!, response['msg']);
        return frontPageResponseModel;
      }
      // Endpoints.donnaDeals.logError( apiName : Endpoints.donnaDeals ,error: response);
      // DialogHelper.showErrorDialog(
      //   title: 'Error Updating',
      //   description: response['msg'],
      // );
      return FrontPageResponseModel(data: []);
    } catch (e) {
      // Endpoints.donnaDeals.logError(apiName: Endpoints.donnaDeals, error: e);
      return FrontPageResponseModel(data: []);
    }
  }

  static Future<DonnaFavouriteResponseModel> donnaFavourite(
      {required PaginationModel payload}) async {
    try {
      // payload.toString().logRequest(apiName: Endpoints.donnaDeals);

      var response = await APIManager()
          .postAPICall(url: Endpoints.donnaFavourite, param: payload);

      DonnaFavouriteResponseModel donnaFavouriteResponseModel =
          DonnaFavouriteResponseModel.fromJson(response);

      //
      // log(response.toString(), name: "${Endpoints.donnaDeals}");
      // response.toString().logResponse(apiName: Endpoints.donnaDeals);
      if (response == null) {
        return DonnaFavouriteResponseModel(data: []);
      }

      // DialogHelper.closeDialog();

      if (donnaFavouriteResponseModel.status == true) {
        // _userController.userModel = UserModel.fromMap(response['data']);
        // DialogHelper.showToast(Get.context!, response['msg']);
        return donnaFavouriteResponseModel;
      }
      // Endpoints.donnaDeals.logError( apiName : Endpoints.donnaDeals ,error: response);
      // DialogHelper.showErrorDialog(
      //   title: 'Error Updating',
      //   description: response['msg'],
      // );
      return DonnaFavouriteResponseModel(data: []);
    } catch (e) {
      // Endpoints.donnaDeals.logError(apiName: Endpoints.donnaDeals, error: e);
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
      } else {
        log(staticPagesResponse.data![0].pageContent.toString(),
            name: "Help", error: "sdfdfdfgdkfjdkfjdkfjdk");
        print("${staticPagesResponse.status.toString()}==============");
      }
      return staticPagesResponse.data!;
    } catch (e) {
      log("API", name: "Help", error: e.toString());
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
        // if (context.mounted) {
        //   DialogHelper.showToast(context, "Error sending user login data");
        // }
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
    try {
      // payload.toString().logRequest(apiName: Endpoints.donnaDeals);

      log("${payload.toString()}", name: "Notification ");
      final response = await http.post(
          Uri.parse("${Endpoints.baseUrl}${Endpoints.notificationList}"),
          body: payload);
      log("${response.body}", name: "Notification Data");
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

      return NotificationResponseModel(posts: []);
    } catch (e) {
      log("API", name: "API Deals 1 $payload", error: e);
      // Endpoints.donnaDeals.logError(apiName: Endpoints.donnaDeals, error: e);
      return NotificationResponseModel(posts: []);
    }
  }

  ///  Notification Status API
  static Future<bool> notificationStatusAPI({required Map payload}) async {
    try {
      // payload.toString().logRequest(apiName: Endpoints.donnaDeals);

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
      log("API", name: "API Deals 2 $payload", error: e);
      // Endpoints.donnaDeals.logError(apiName: Endpoints.donnaDeals, error: e);
      return false;
    }
  }
}
