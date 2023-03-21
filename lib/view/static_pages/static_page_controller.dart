import 'dart:developer';

import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/static_page_model.dart';
import 'package:humble_warrior/network/api_call.dart';

class StaticPagesController extends GetxController{

  late String id;

  RxList<StaticData> staticPagesResponse = <StaticData>[].obs;

  @override
  void onInit() {
    // staticPageApi(id);

    super.onInit();
  }

  Future<List<StaticData>> staticPageApi(String id) async {
    StaticPageID payload = StaticPageID(id: id);
    log(staticPagesResponse.value.toString(),name: "Help" ,error: "$id sdfdfdfgdkfjdkfjdkfjdk");

    return staticPagesResponse.value = await CallAPI.staticPages(payload: payload);

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