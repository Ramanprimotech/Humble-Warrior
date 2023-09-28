import 'package:hive/hive.dart';

part 'recent_search_model.g.dart';

@HiveType(typeId: 2)
class RecentSearch {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? productSearched;

  RecentSearch({this.id, this.productSearched});
}
