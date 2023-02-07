import 'package:flutter/cupertino.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController textEditingController;
  const CustomSearchBar({Key? key, required this.textEditingController})
      : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      controller: widget.textEditingController,
      placeholder: "Search",
      prefixIcon: Icon(CupertinoIcons.airplane),
      suffixIcon: Icon(CupertinoIcons.search),
    );
  }
}
