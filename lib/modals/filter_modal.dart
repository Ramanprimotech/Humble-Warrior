class FilterModal  {
  String header;
  int? selected;
  List<String> subHeader;

  FilterModal({
    required this.header,
     this.selected = -1,
    required this.subHeader,
  });
}
