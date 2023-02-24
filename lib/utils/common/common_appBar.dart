import 'package:flutter/material.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:get/get.dart';

class CommonAppBar {
  AppBar AppBarWidget({
    required Widget title,
    double? leadWidth,
    bool showBackButton = false,
    List<Widget>? actions,
  }){
    return AppBar(
      title: Padding(
        padding: 20.pr,
        child: title,
      ),
      leadingWidth: leadWidth??30,
      leading: showBackButton == true? InkWell(
        onTap: (){
          Get.back();
        },
        child: Padding(
          padding: 20.pl,
          child: Icon(Icons.arrow_back_ios,
            color: Theme.of(Get.context!).textTheme.displaySmall!.color!,
          ),
        ),
      ):const SizedBox(),
      actions: actions,
    );
  }
}




/*class CommonAppBar extends StatelessWidget {
  const CommonAppBar({
    Key? key,
    required this.title,
    this.leadWidth,
    this.showBackButton = false,
    this.actions,
    this.height,
  }) : super(key: key);
  final Widget? title;
  final double? leadWidth;
  final bool showBackButton;
  final List<Widget>? actions;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: 15.ph,
        child: title,
      ),
      leadingWidth: leadWidth??20,
      leading: showBackButton == true? Padding(
        padding: 20.pl,
        child: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios,
            color: Theme.of(context).textTheme.displaySmall!.color!,
          ),
        ),
      ):SizedBox(),
      actions: actions,
    );
  }
}*/



/*
class CustomAppBar extends StatelessWidget{
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
        padding: 15.ph,
        child: title,
      ),
      leadingWidth: leadWidth??20,
      leading: showBackButton ? Padding(
        padding: 20.pl,
        child: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios,
            color: Theme.of(context).textTheme.displaySmall!.color!,),
        ),
      ) : SizedBox(),
      actions: actions,
    );
  }
}*/
