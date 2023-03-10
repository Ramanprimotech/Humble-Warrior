import 'package:get/get.dart';
import 'package:humble_warrior/modals/filter_modal.dart';

class SortController extends GetxController{

   List<FilterModal> filterData = [
    FilterModal(header: "Price", subHeader: ["Low to High", "High to Low"]),
    FilterModal(header: "Sort", subHeader: ["Recent", "A-Z", "Z-A"]),
  ];

  RxBool isSelected = false.obs;
  RxBool isItemSelected = false.obs;
   List<FilterModal> filterSelectionList = [];

  filterInitialData(){
    filterData.clear();
    filterData.addAll(filterSelectionList);
  }

  checkFilter(){
    Iterable<FilterModal> data = filterData.where((element) => element.selected != -1);
    isItemSelected.value = data.length != 0;
  }

  back(){
    filterData.clear();
    filterData.addAll(filterSelectionList);
    Get.back();
  }

  reset(){
    filterData[headerIndex.value].selected=-1;
    headerIndex = 0.obs;
    filterData.forEach((element) {element.selected=(-1);});
    checkFilter();
  }

  apply(){
    filterSelectionList.clear();
    filterSelectionList.addAll(filterData);
    Get.back();
  }

  RxInt headerIndex = 0.obs;

   @override
  void onInit() {
     filterSelectionList.addAll(filterData);
     checkFilter();
      filterData.forEach((element) {
  });

  }
}
