class FilterModal  {
  String header;
  int? selected;
  List<String> subHeader;

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
