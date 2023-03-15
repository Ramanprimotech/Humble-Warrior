class FilterModal {
  String header;
  int? selected;
  List<SortItem> subHeader;

  FilterModal({
    required this.header,
    this.selected = -1,
    required this.subHeader,
  });

  @override
  String toString() {
    return 'FilterModal{header: $header, selected: $selected, subHeader: $subHeader}';
  }
}

class SortItem {
  final String itemnName;
  final String itemValue;
  final String type;

  const SortItem({
    required this.itemnName,
    required this.itemValue,
    required this.type,
  });

  @override
  String toString() {
    return 'SortItem{itemnName: $itemnName, itemValue: $itemValue, type: $type}';
  }
}
