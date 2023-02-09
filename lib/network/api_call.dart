import 'dart:developer';

import 'package:humble_warrior/modals/response/donna_deals_response.dart';
import 'package:humble_warrior/modals/response/donna_favourite_response_model.dart';
import 'package:humble_warrior/modals/response/front_page_response_model.dart';
import 'package:humble_warrior/modals/response/token_response.dart';
import 'package:humble_warrior/network/endpoints.dart';

import '../modals/requests/pagination_modal.dart';
import '../modals/requests/token_model_request.dart';
import 'api_manager.dart';

class CallAPI {
  static Future<TokenResponseModel> generateToken(
      {required TokenRequestModel payload}) async {
    try {
      // payload.toString().logRequest(apiName: Endpoints.generateToken);

      final response = await APIManager()
          .postAPICallNoBearer(url: Endpoints.generateToken, param: payload);

      var tokenResponseModel = TokenResponseModel.fromJson(response);
      // log(response.toString(), name: "${Endpoints.generateToken}");
      // response.toString().logResponse(apiName: Endpoints.generateToken);
      // if (response == null) {
      //   return response.;
      // }

      // DialogHelper.closeDialog();

      // if (response['status'] == 1) {
      //   // _userController.userModel = UserModel.fromMap(response['data']);
      //   // DialogHelper.showToast(Get.context!, response['msg']);
      //   return true;
      // }
      // Endpoints.generateToken
      //     .logError(apiName: Endpoints.generateToken, error: response);
      // DialogHelper.showErrorDialog(
      //   title: 'Error Updating',
      //   description: response['msg'],
      // );
      return tokenResponseModel;
    } catch (e, st) {
      // Endpoints.generateToken
      //     .logError(apiName: Endpoints.generateToken, error: e);
      log(e.toString());
      return TokenResponseModel();
    }
  }

  static Future verifyToken({required double payload}) async {
    try {
      // payload.toString().logRequest(apiName: Endpoints.verifyToken);

      dynamic response = await APIManager()
          .postAPICall(url: Endpoints.verifyToken, param: payload);

      // log(response.toString(), name: "${Endpoints.verifyToken}");
      // response.toString().logResponse(apiName: Endpoints.verifyToken);
      if (response == null) {
        return false;
      }

      // DialogHelper.closeDialog();

      if (response['status'] == 1) {
        // _userController.userModel = UserModel.fromMap(response['data']);
        // DialogHelper.showToast(Get.context!, response['msg']);
        return true;
      }
      // Endpoints.verifyToken.logError( apiName : Endpoints.verifyToken ,error: response);
      // DialogHelper.showErrorDialog(
      //   title: 'Error Updating',
      //   description: response['msg'],
      // );
      return false;
    } catch (e, st) {
      // Endpoints.verifyToken.logError(apiName: Endpoints.verifyToken, error: e);
      return false;
    }
  }

  static Future<List<DonnaDealsDetails>> donnaDeals(
      {required PaginationModel payload}) async {
    try {
      // payload.toString().logRequest(apiName: Endpoints.donnaDeals);

      var response = await APIManager()
          .postAPICall(url: Endpoints.donnaDeals, param: payload);

      DonnaDealsResponseModal donnaDealsResponseModal =
          DonnaDealsResponseModal.fromJson(response);

      //
      // log(response.toString(), name: "${Endpoints.donnaDeals}");
      // response.toString().logResponse(apiName: Endpoints.donnaDeals);
      if (response == null) {
        return [];
      }

      // DialogHelper.closeDialog();

      if (donnaDealsResponseModal.status == true) {
        // _userController.userModel = UserModel.fromMap(response['data']);
        // DialogHelper.showToast(Get.context!, response['msg']);
        return donnaDealsResponseModal.data!;
      }
      // Endpoints.donnaDeals.logError( apiName : Endpoints.donnaDeals ,error: response);
      // DialogHelper.showErrorDialog(
      //   title: 'Error Updating',
      //   description: response['msg'],
      // );
      return [];
    } catch (e, st) {
      // Endpoints.donnaDeals.logError(apiName: Endpoints.donnaDeals, error: e);
      return [];
    }
  }

  static Future<List<FrontPageDetails>> frontPage(
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
        return [];
      }

      // DialogHelper.closeDialog();

      if (frontPageResponseModel.status == true) {
        // _userController.userModel = UserModel.fromMap(response['data']);
        // DialogHelper.showToast(Get.context!, response['msg']);
        return frontPageResponseModel.data!;
      }
      // Endpoints.donnaDeals.logError( apiName : Endpoints.donnaDeals ,error: response);
      // DialogHelper.showErrorDialog(
      //   title: 'Error Updating',
      //   description: response['msg'],
      // );
      return [];
    } catch (e, st) {
      // Endpoints.donnaDeals.logError(apiName: Endpoints.donnaDeals, error: e);
      return [];
    }
  }

  static Future<List<DonnaFavouriteDetails>> donnaFavourite(
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
        return [];
      }

      // DialogHelper.closeDialog();

      if (donnaFavouriteResponseModel.status == true) {
        // _userController.userModel = UserModel.fromMap(response['data']);
        // DialogHelper.showToast(Get.context!, response['msg']);
        return donnaFavouriteResponseModel.data!;
      }
      // Endpoints.donnaDeals.logError( apiName : Endpoints.donnaDeals ,error: response);
      // DialogHelper.showErrorDialog(
      //   title: 'Error Updating',
      //   description: response['msg'],
      // );
      return [];
    } catch (e, st) {
      // Endpoints.donnaDeals.logError(apiName: Endpoints.donnaDeals, error: e);
      return [];
    }
  }
}
