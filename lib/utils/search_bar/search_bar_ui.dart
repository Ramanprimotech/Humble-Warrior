import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/app_themes/app_theme_controller.dart';

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
    final ThemeController themeController = Get.find();
    bool isDark = themeController.themeMode == ThemeMode.dark;
    return PreferredSize(
      preferredSize: Size.fromHeight(widget.height ?? 60),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Container(
          height: 42,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Theme.of(context).textTheme.displaySmall!.color!, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image.asset(
                  !isDark?
                  ImagePathAssets.hwLogoUnnamed:
                  ImagePathAssets.hwLogoUnnamedDark,
                  height: 40,
                  width: 40,
                ),
              ),
              Row(
                children: const [
                  Icon(Icons.search),
                  AppText(
                    searchTxt,
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

class CustomAppBar extends StatefulWidget  {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.onTap,
    this.actions,
    this.height,
    this.leadWidth,
    this.showBackButton = true,
  }) : super(key: key);

  final Widget? title;
  final VoidCallback? onTap;
  final List<Widget>? actions;
  final bool showBackButton;
  final double? height;
  final double? leadWidth;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();


}

class _CustomAppBarState extends State<CustomAppBar>  {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: widget.title,
      ),
      leadingWidth: widget.leadWidth??20,
      leading: widget.showBackButton ? Padding(
        padding: const EdgeInsets.only(left: 20),
        child:
         GestureDetector(
           onTap: (){
             Get.back();
           },
           child: Icon(Icons.arrow_back_ios,
                  color: Theme.of(context).textTheme.displaySmall!.color!,),
         ),
      ) : SizedBox(),
      actions: widget.actions,
    );
  }
}


/*
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.onTap,
    this.actions,
    this.height,
    this.leadWidth,
    this.showBackButton = true,
  }) : super(key: key);

  final Widget? title;
  final VoidCallback? onTap;
  final List<Widget>? actions;
  final bool showBackButton;
  final double? height;
  final double? leadWidth;

  @override
  Size get preferredSize => Size.fromHeight(height ?? 60);

  static final ThemeController _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: title,
      ),
      leadingWidth: leadWidth??20,
      leading: showBackButton ? Padding(
          padding: const EdgeInsets.only(left: 20),
          child: BackButton(),

        */
/*IconButton(
              onPressed: (){
                print("click");
                // Get.back();
              },
              icon: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).textTheme.displaySmall!.color!,)),*//*

      ) : SizedBox(),
      actions: actions,
    );
  }
}*/
