import 'package:humble_warrior/hw.dart';

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
      categoryList.clear();
    }
    PaginationModel paginationModel =
        PaginationModel(page: categoryListPage.toString(), categoryId: id);
    await CallAPI.productListAPI(
            payload: paginationModel, url: Endpoints.productCategoriesItemList)
        .then((value) {
      if (value.data == null) {
        DialogHelper.showToast(context, "No More Deals Found");
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
