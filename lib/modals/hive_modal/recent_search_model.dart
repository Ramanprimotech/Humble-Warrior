import 'package:hive/hive.dart';

part 'recent_search_model.g.dart';

@HiveType(typeId: 2)
class RecentSearch {
  @HiveField(0)
  String? productSearched;

  RecentSearch({required this.productSearched});
}
