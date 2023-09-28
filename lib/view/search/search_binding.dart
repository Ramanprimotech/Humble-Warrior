import 'package:humble_warrior/view/filter/filter_controller.dart';
import 'package:humble_warrior/view/sorting/sort_controller.dart';

import 'package:humble_warrior/hw.dart';

class SearchViewBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>  SearchViewBindings());
    Get.put(SortController());
    Get.put(FilterController());
  }
}
