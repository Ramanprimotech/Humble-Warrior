import 'package:humble_warrior/hw.dart';

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
    return Container(
      height: 50,
      width: double.infinity,
      padding: 8.pa,
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Theme.of(context).textTheme.displaySmall!.color!),
          borderRadius: BorderRadius.circular(24)),
      child: Row(
        children: [
          Image.asset(
            !isDark
                ? ImagePathAssets.hwLogoUnnamed
                : ImagePathAssets.hwLogoUnnamedDark,
            height: 40,
            width: 40,
          ),
          const Spacer(),
          const Icon(Icons.search),
          const AppText(searchTxt, fontWeight: FontWeight.w700),
          const Spacer(),
        ],
      ),
    );
  }
}

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
