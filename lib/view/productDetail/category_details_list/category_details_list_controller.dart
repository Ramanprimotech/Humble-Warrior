import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/requests/pagination_modal.dart';
import 'package:humble_warrior/modals/response/product_details_response.dart';
import 'package:humble_warrior/network/api_call.dart';
import 'package:humble_warrior/network/endpoints.dart';
import 'package:humble_warrior/utils/helpers/dialog_helper.dart';

class CategoryDetailsListController extends GetxController {
  RxInt categoryListLength = 0.obs;
  List<ProductDetailsResponse> categoryList = [];
  final RxBool categoryListBool = true.obs;
  int categoryListPage = 1;
  RxInt categoryListTotalDeals = 20.obs;
  late BuildContext context;
  late String id;
  final ScrollController categoryListScrollController =
      ScrollController(initialScrollOffset: 0.0);

  @override
  void onInit() {
    // categoryListApi();
    super.onInit();
  }

  Future categoryListApi({bool? refresh = false}) async {
    if (refresh!) {
      categoryListPage = 1;
      // donnaDealsBool.value = true;
      categoryList.clear();
      // update();
    }
    PaginationModel paginationModel =
        PaginationModel(page: categoryListPage.toString(), categoryId: id);
    await CallAPI.productListAPI(
            payload: paginationModel, url: Endpoints.productCategoriesItemList)
        .then((value) {
      if (value.data == null) {
        DialogHelper.showToast(context, "No Deals Found");
      } else {
        categoryListPage += 1;
        categoryList.addAll(value.data!);
        categoryListLength.value = categoryList.length;
        if (refresh) {
          DialogHelper.showToast(context, "Deals Refreshed");
        }
      }
      if (value.totalRecords != null) {
        categoryListTotalDeals.value = int.parse(value.totalRecords!);
      }
      categoryListBool.value = false;
      update();
    });
  }
}
