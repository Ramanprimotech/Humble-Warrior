import 'package:get/get.dart';
import 'package:humble_warrior/modals/filter_modal.dart';

class SortController extends GetxController {
  Function? additionalApplySort;
  List<FilterModal> filterData = [
    FilterModal(header: "Sort", subHeader: [
      const SortItem(itemnName: "Latest", itemValue: "DECS", type: "date"),
      const SortItem(itemnName: "Oldest", itemValue: "ASC", type: "date"),
      const SortItem(itemnName: "A-Z", itemValue: "ASC", type: "name"),
      const SortItem(itemnName: "Z-A", itemValue: "DECS", type: "name")
    ]),
    // FilterModal(header: "Name", subHeader: ["A-Z", "Z-A"]),
  ];

  RxBool isSelected = false.obs;
  RxBool isItemSelected = false.obs;
  List<FilterModal> filterSelectionList = [];

  filterInitialData() {
    filterData.clear();
    filterData.addAll(filterSelectionList);
  }

  checkFilter() {
    Iterable<FilterModal> data =
        filterData.where((element) => element.selected != -1);
    isItemSelected.value = data.length != 0;
    return isItemSelected.value;
  }

  back() {
    filterData.clear();
    filterData.addAll(filterSelectionList);
    Get.back();
  }

  reset() {
    filterData[headerIndex.value].selected = -1;
    filterData.clear();
    filterData.addAll(filterSelectionList);
    headerIndex.value = 0;
    filterData.forEach((element) {
      element.selected = (-1);
    });
    checkFilter();
    update(['sort']);
  }

  apply() {
    filterSelectionList.clear();
    filterSelectionList.addAll(filterData);
    if (additionalApplySort != null) {
      additionalApplySort!();
    }
    Get.back();
  }

  RxInt headerIndex = 0.obs;

  @override
  void onInit() {
    filterSelectionList.addAll(filterData);
    checkFilter();
  }
}
