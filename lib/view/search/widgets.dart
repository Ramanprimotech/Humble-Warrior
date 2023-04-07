import 'package:humble_warrior/hw.dart';

class SearchBar extends StatelessWidget {
  const SearchBar(
      {Key? key,
      this.child,
      this.margin,
      this.padding,
      this.postType,
      this.item})
      : super(key: key);

  final Widget? child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String? postType;
  final ProductCategoryItem? item;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    bool isDark = themeController.themeMode == ThemeMode.dark;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: GestureDetector(
        child: Container(
          height: 45,
          width: double.infinity,
          padding: padding ?? 8.pa,
          margin: margin ?? 0.pa,
          decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: Theme.of(context).textTheme.displaySmall!.color!.withOpacity(.5)),
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
          ProductCategoryItem items =
              item == null ? ProductCategoryItem() : item!;
          Get.toNamed(AppRoutes.searchView, arguments: [
            postType.isEmptyOrNull ? "" : postType.toString(),
            items.id == null ? "" : items.id.toString(),
            items.categoryName == null ? "" : items.categoryName.toString(),
            items.categoryImage == null ? "" : items.categoryImage.toString()
          ]);
        },
      ),
    );
  }
}

class FilterIcon extends StatelessWidget {
  const FilterIcon(
      {Key? key,
      this.child,
      this.margin,
      this.padding,
      this.postType,
      this.item})
      : super(key: key);

  final Widget? child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String? postType;
  final ProductCategoryItem? item;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: 16.pr,
        onPressed: () {
          ProductCategoryItem items =
              item == null ? ProductCategoryItem() : item!;
          Get.toNamed(AppRoutes.searchView, arguments: [
            postType.isEmptyOrNull ? "" : postType.toString(),
            items.id == null ? "" : items.id.toString(),
            items.categoryName == null ? "" : items.categoryName.toString(),
            items.categoryImage == null ? "" : items.categoryImage.toString()
          ]);
        },
        icon: AppIcons.filter(size: 35));
  }
}
