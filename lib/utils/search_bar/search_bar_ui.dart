import 'package:humble_warrior/hw.dart';

class CustomAppBar extends StatelessWidget {
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
      leadingWidth: leadWidth ?? 20,
      leading: showBackButton
          ? Padding(
              padding: 20.pl,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).textTheme.displaySmall!.color!,
                ),
              ),
            )
          : const SizedBox(),
      actions: actions,
    );
  }
}
