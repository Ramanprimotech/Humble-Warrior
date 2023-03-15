import 'package:get/get.dart';
import 'package:humble_warrior/view/search/view.dart';
import 'package:humble_warrior/view/sorting/sort_controller.dart';

class SearchViewBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => const SearchView());
    Get.put(SortController());
  }
}
