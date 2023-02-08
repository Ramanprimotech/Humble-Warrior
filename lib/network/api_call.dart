import 'package:humble_warrior/modals/response/donna_deals_response.dart';
import 'package:humble_warrior/network/endpoints.dart';

import '../modals/requests/pagination_modal.dart';
import '../modals/requests/token_model_request.dart';
import '../utils/helpers/dialog_helper.dart';
import 'api_manager.dart';

class CallAPI {
  static Future generateToken({required TokenRequestModel payload}) async {
    try {
      // payload.toString().logRequest(apiName: Endpoints.generateToken);

      dynamic response =
          await APIManager().postAllCallNonParam(url: Endpoints.generateToken);

      // log(response.toString(), name: "${Endpoints.generateToken}");
      // response.toString().logResponse(apiName: Endpoints.generateToken);
      if (response == null) {
        return false;
      }

      DialogHelper.closeDialog();

      if (response['status'] == 1) {
        // _userController.userModel = UserModel.fromMap(response['data']);
        // DialogHelper.showToast(Get.context!, response['msg']);
        return true;
      }
      // Endpoints.generateToken
      //     .logError(apiName: Endpoints.generateToken, error: response);
      // DialogHelper.showErrorDialog(
      //   title: 'Error Updating',
      //   description: response['msg'],
      // );
      return false;
    } catch (e, st) {
      // Endpoints.generateToken
      //     .logError(apiName: Endpoints.generateToken, error: e);
      return false;
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

  static Future<List<DonnaDealsList>> donnaDeals(
      {required PaginationModel payload}) async {
    try {
      // payload.toString().logRequest(apiName: Endpoints.donnaDeals);

      DonnaDealsResponseModal response = await APIManager()
          .postAPICall(url: Endpoints.donnaDeals, param: payload);
      //
      // log(response.toString(), name: "${Endpoints.donnaDeals}");
      // response.toString().logResponse(apiName: Endpoints.donnaDeals);
      if (response == null) {
        return [];
      }

      // DialogHelper.closeDialog();

      if (response.status == true) {
        // _userController.userModel = UserModel.fromMap(response['data']);
        // DialogHelper.showToast(Get.context!, response['msg']);
        return response.data!;
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
