import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/requests/pagination_modal.dart';
import 'package:humble_warrior/modals/response/donna_deals_response.dart';
import 'package:humble_warrior/network/api_call.dart';
import 'package:humble_warrior/utils/helpers/dialog_helper.dart';

class CategoryDetailsListController extends GetxController{
  RxInt categoryListLength = 0.obs;
  List<DonnaDealsDetails> categoryList = [];
  final RxBool categoryListBool = true.obs;
  int categoryListPage = 1;
  RxInt categoryListTotalDeals = 20.obs;
  late BuildContext context;
  final ScrollController categoryListScrollController =
  ScrollController(initialScrollOffset: 0.0);

  @override
  void onInit() {
   categoryListApi();
    super.onInit();
  }

  Future categoryListApi({bool? refresh = false}) async {
    if (refresh!) {
      categoryListPage = 1;
      categoryListBool.value = true;
      categoryList.clear();
      update();
    }
    PaginationModel paginationModel =
    PaginationModel(page: categoryListPage.toString());
    await CallAPI.donnaDeals(payload: paginationModel).then((value) {
      if (value.data == null) {
        DialogHelper.showToast(context, "No Deals Found");
      } else {
        categoryListPage += 1;
        categoryList.addAll(value.data!);
        categoryListLength.value = categoryList.length;
      }
      if (value.totalRecords != null) {
        categoryListTotalDeals.value = int.parse(value.totalRecords!);
      }
      categoryListBool.value = false;
      update();
    });
  }

}