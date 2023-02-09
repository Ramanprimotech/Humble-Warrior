import 'package:flutter/cupertino.dart';
import 'package:humble_warrior/utils/app_colors.dart';

import '../image_path_assets.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final Function()? onTap;
  final Function(String? text)? onSuffix;
  final Function(String? text)? onSubmit;

  const CustomSearchBar(
      {Key? key,
      required this.textEditingController,
      required this.focusNode,
      this.onTap,
      this.onSubmit,
      this.onSuffix})
      : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: CupertinoSearchTextField(
        focusNode: widget.focusNode,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.grey, width: 1.5)),
        controller: widget.textEditingController,
        placeholder: "Search",
        prefixInsets: const EdgeInsets.only(left: 15, right: 10),
        suffixInsets: const EdgeInsets.only(right: 15),
        suffixMode: OverlayVisibilityMode.editing,
        prefixIcon: Image.asset(
          ImagePathAssets.hw_logo,
          height: 40,
          width: 40,
        ),
        onChanged: (String? text) {},
        onSubmitted: widget.onSubmit ?? (String? text) {},
        onTap: widget.onTap ??
            () {
              debugPrint("taped");
            },
      ),
    );
  }
}
