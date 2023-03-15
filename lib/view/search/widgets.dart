import 'package:humble_warrior/hw.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key, this.child, this.margin, this.padding})
      : super(key: key);

  final Widget? child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    bool isDark = themeController.themeMode == ThemeMode.dark;
    return GestureDetector(
      child: Container(
        height: 45,
        width: double.infinity,
        padding: padding ?? 8.pa,
        margin: margin ?? 0.pa,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Theme.of(context).textTheme.displaySmall!.color!),
          borderRadius: BorderRadius.circular(24),
        ),
        child: child ??
            Row(
              children: [
                Image.asset(
                  !isDark
                      ? ImagePathAssets.hwLogoUnnamed
                      : ImagePathAssets.hwLogoUnnamedDark,
                  height: 40,
                  width: 40,
                ),
                const Spacer(),
                const Icon(Icons.search, size: 20),
                AppText(searchTxt,
                    fontWeight: FontWeight.w400, fontSize: 14, padding: 4.pl),
                const Spacer(),
                20.swb,
              ],
            ),
      ),
      onTap: () {
        Get.toNamed(AppRoutes.searchView);
      },
    );
  }
}
