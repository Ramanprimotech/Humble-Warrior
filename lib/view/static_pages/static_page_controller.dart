import 'dart:developer';

import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/static_page_model.dart';
import 'package:humble_warrior/network/api_call.dart';

class StaticPagesController extends GetxController{

  String id = Get.arguments;

  RxList<StaticData> staticPagesResponse = <StaticData>[].obs;

  @override
  void onInit() {
    staticPageApi(id);

    super.onInit();
  }

  Future<void> staticPageApi(String id) async {
    StaticPageID payload = StaticPageID(id: id);
    staticPagesResponse.value = await CallAPI.staticPages(payload: payload);
    log(staticPagesResponse.value.toString(),name: "Help" ,error: "sdfdfdfgdkfjdkfjdkfjdk");

  }

}

class StaticPageID{
  String? id;

  StaticPageID({this.id});

  StaticPageID.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}