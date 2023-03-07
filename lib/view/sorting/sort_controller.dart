import 'package:get/get.dart';
import 'package:humble_warrior/modals/filter_modal.dart';

class SortController extends GetxController{

   List<FilterModal> filterData = [
    FilterModal(header: "Price", subHeader: ["Low to High", "High to Low"]),
    FilterModal(header: "Sort", subHeader: ["Recent", "A-Z", "Z-A"]),
  ];

  RxInt check = (-1).obs;
  RxBool isSelected = false.obs;

  click(int id){
      check.value = id;
  }

  reset(){
    check.value=-1;
    filterData.forEach((element) {element.selected=(-1);});
  }

  RxInt headerIndex = 0.obs;
  RxInt _sortIndex = 0.obs;



}

/*
enum Sort{
  sort,
  price,
  alpha,
  popularity,
  defult
}*/
