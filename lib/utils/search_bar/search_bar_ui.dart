import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_text.dart';

import '../image_path_assets.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final Function()? onTap;
  final double? height;
  final Function(String? text)? onSuffix;
  final Function(String? text)? onSubmit;
  final Function(String? text)? onChange;

  const CustomSearchBar(
      {Key? key,
      this.textEditingController,
      this.focusNode,
      this.onTap,
      this.onSubmit,
      this.onChange,
      this.onSuffix,
      this.height})
      : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(widget.height ?? 60),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Container(
          height: 42,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.black, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image.asset(
                  ImagePathAssets.hwLogoUnnamed,
                  height: 40,
                  width: 40,
                ),
              ),
              Row(
                children: const [
                  Icon(Icons.search),
                  AppText(
                    "Search",
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              const SizedBox(
                width: 40,
              ),
            ],
          ),

          // TextField(
          //   textAlign: TextAlign.center,
          //   focusNode: widget.focusNode,
          //   controller: widget.textEditingController,
          //   decoration: InputDecoration(
          //     contentPadding: EdgeInsets.all(12),
          //     prefixIcon: Padding(
          //       padding: const EdgeInsets.only(left: 10.0),
          //       child: Image.asset(
          //         ImagePathAssets.hwLogoUnnamed,
          //         height: 40,
          //         width: 40,
          //       ),
          //     ),
          //     hintText: "Search",
          //
          //     suffixIcon: Visibility(
          //         visible: widget.focusNode.hasFocus, child: AppIcons.cross()),
          //     border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(50),
          //         borderSide:
          //             const BorderSide(color: AppColors.black, width: 1)),
          //     focusedBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(50),
          //         borderSide:
          //             const BorderSide(color: AppColors.black, width: 1)),
          //   ),
          // ),
        ),

        // CupertinoSearchTextField(
        //   focusNode: widget.focusNode,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(50),
        //       border: Border.all(color: AppColors.grey, width: 1.5)),
        //   controller: widget.textEditingController,
        //   placeholder: "           Search",
        //   prefixInsets: const EdgeInsets.only(left: 15, right: 10),
        //   suffixInsets: const EdgeInsets.only(right: 15),
        //   suffixMode: OverlayVisibilityMode.editing,
        //   prefixIcon: Image.asset(
        //     ImagePathAssets.hwLogo,
        //     height: 40,
        //     width: 40,
        //   ),
        //   onChanged: widget.onChange ?? (String? text) {},
        //   onSubmitted: widget.onSubmit ?? (String? text) {},
        //   onTap: widget.onTap ??
        //       () {
        //         debugPrint("taped");
        //       },
        // ),
      ),
    );
  }
}
