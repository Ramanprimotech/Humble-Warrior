import 'package:humble_warrior/hw.dart';

class StaticPagesController extends GetxController {
  late String id;

  RxList<StaticData> staticPagesResponse = <StaticData>[].obs;

  @override
  void onInit() {
    // staticPageApi(id);

    super.onInit();
  }

  Future<List<StaticData>> staticPageApi(String id) async {
    StaticPageID payload = StaticPageID(id: id);

    return staticPagesResponse.value =
        await CallAPI.staticPages(payload: payload);
  }
}

class StaticPageID {
  String? id;

  StaticPageID({this.id});

  StaticPageID.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
