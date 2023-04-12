import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/view/sorting/sort_controller.dart';

class HomeOptionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  RxInt selectedIndex = 0.obs;
  RxBool select = false.obs;
  int initialIndex = Get.arguments[0];
  late BuildContext context;
  HiveService service = Get.find<HiveService>();
  final SortController _sortController = Get.find();

  ///Storage has item
  bool hasItemInDatabase(String id) {
    return service.hasItem(
      id,
    );
  }

  /// Donna's Deals
  final RxInt donnaDealsLength = 0.obs;
  final RxBool donnaDealsBool = true.obs;
  List<ProductDetailsResponse> donnaDealList = [];
  RxInt donnaDealListLength = 0.obs;
  int donnaDealsPage = 1;
  RxInt donnaDealsTotalDeals = 20.obs;
  final ScrollController donnaDealScrollController =
      ScrollController(initialScrollOffset: 0.0);

  /// Front Page Deals
  final RxInt frontPageDealsLength = 0.obs;
  final RxBool frontPageDealsBool = true.obs;
  RxInt frontPageDealsTotalDeals = 20.obs;
  List<ProductDetailsResponse> frontPageDealList = [];
  RxInt frontPageDealListLength = 0.obs;
  int frontPageDealsPage = 1;
  final ScrollController frontPageDealScrollController =
      ScrollController(initialScrollOffset: 0.0);

  /// Donna's Favourite
  final RxInt donnaFavouriteDealsLength = 0.obs;
  final RxBool donnaFavouriteDealsBool = true.obs;
  List<ProductDetailsResponse> donnaFavouriteDealList = [];
  RxInt donnaFavouriteDealsTotalDeals = 20.obs;
  int donnaFavouriteDealsPage = 1;
  RxInt donnaFavouriteDealListLength = 0.obs;
  final ScrollController donnaFavouriteDealScrollController =
      ScrollController(initialScrollOffset: 0.0);

  @override
  void onInit() {
    _sortController.additionalApplySort = functionSort;
    tabController =
        TabController(length: 3, initialIndex: initialIndex, vsync: this);
    tabController.addListener(() {
      selectedIndex.value = tabController.index;
    });
    Future.wait(
        [donaDealsAPI(), donnaFavouriteDealsAPI(), frontPageDealsAPI()]);
    super.onInit();
  }

  Future donaDealsAPI({bool? refresh = false}) async {
    if (refresh!) {
      donnaDealsPage = 1;
      // donnaDealsBool.value = true;
      donnaDealList.clear();
      // update();
    }
    SortItem item = sort();
    PaginationModel paginationModel = PaginationModel(
        page: donnaDealsPage.toString(),
        sortName: item.type,
        sortOrder: item.itemValue
    );
    await CallAPI.productListAPI(
            payload: paginationModel, url: Endpoints.donnaDeals)
        .then((value) {
      if (value.data == null) {
        DialogHelper.showToast(context, noMoreDealsTxt);
      } else {
        donnaDealsPage += 1;
        donnaDealList.addAll(value.data!);
        donnaDealListLength.value = donnaDealList.length;
        if (refresh) {
          DialogHelper.showToast(context, dealsRefreshTxt);
        }
      }
      if (value.totalRecords != null) {
        donnaDealsTotalDeals.value = int.parse(value.totalRecords!);
      }
      donnaDealsBool.value = false;
      update();
    });
  }

  Future frontPageDealsAPI({bool? refresh = false}) async {
    if (refresh!) {
      frontPageDealsPage = 1;
      frontPageDealList.clear();
    }
    SortItem item = sort();
    PaginationModel paginationModel = PaginationModel(
        page: frontPageDealsPage.toString(),
        sortName: item.type,
        sortOrder: item.itemValue);
    await CallAPI.productListAPI(
            payload: paginationModel, url: Endpoints.frontPage)
        .then((value) {
      if (value.data == null) {
        DialogHelper.showToast(context, noMoreDealsTxt);
      } else {
        frontPageDealsPage += 1;
        frontPageDealList.addAll(value.data!);
        frontPageDealListLength.value = frontPageDealList.length;
        if (refresh) {
          DialogHelper.showToast(context, dealsRefreshTxt);
        }
      }

      if (value.totalRecords != null) {
        frontPageDealsTotalDeals.value = int.parse(value.totalRecords!);
      }
      frontPageDealsBool.value = false;
      update();
    });
  }

  Future donnaFavouriteDealsAPI({bool? refresh = false}) async {
    if (refresh!) {
      donnaFavouriteDealsPage = 1;
      donnaFavouriteDealList.clear();
    }
    SortItem item = sort();
    PaginationModel paginationModel = PaginationModel(
        page: donnaFavouriteDealsPage.toString(),
        sortName: item.type,
        sortOrder: item.itemValue);
    await CallAPI.productListAPI(
            payload: paginationModel, url: Endpoints.donnaFavourite)
        .then((value) {
      if (value.data == null) {
        DialogHelper.showToast(context, noMoreDealsTxt);
      } else {
        donnaFavouriteDealsPage += 1;
        donnaFavouriteDealList.addAll(value.data!);
        donnaFavouriteDealListLength.value = donnaFavouriteDealList.length;
        if (refresh) {
          DialogHelper.showToast(context, dealsRefreshTxt);
        }
      }
      if (value.totalRecords != null) {
        donnaFavouriteDealsTotalDeals.value = int.parse(value.totalRecords!);
      }

      donnaFavouriteDealsBool.value = false;
      update();
    });
  }

  SortItem sort() {
    if (!_sortController.checkFilter()) {
      return const SortItem(itemnName: "", itemValue: "", type: "");
    } else {
      return _sortController
              .filterData[_sortController.headerIndex.value].subHeader[
          _sortController
              .filterData[_sortController.headerIndex.value].selected!];
    }
  }

  functionSort() {
    donnaFavouriteDealsPage = 1;
    donnaFavouriteDealList.clear();
    frontPageDealsPage = 1;
    frontPageDealList.clear();
    donnaDealsPage = 1;
    donnaDealList.clear();
    frontPageDealsBool.value = true;
    donnaDealsBool.value = true;
    donnaFavouriteDealsBool.value = true;
    update();
    Future.wait(
        [donaDealsAPI(), donnaFavouriteDealsAPI(), frontPageDealsAPI()]);
  }

  @override
  void onClose() {
    tabController.dispose();
    donnaDealScrollController.dispose();
    donnaFavouriteDealScrollController.dispose();
    frontPageDealScrollController.dispose();
    super.onClose();
  }

  String postType(int position) {
    Map<int, String> post = {
      0: "deals",
      1: "product",
      2: "shopmycloset_product"
    };

    return post[position]!;
  }
}
