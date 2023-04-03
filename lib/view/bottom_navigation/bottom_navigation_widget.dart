import 'package:humble_warrior/hw.dart';

Widget bottomNavigationWidget(BuildContext context) {
  final ImageIconTheme imageIconTheme =
      Theme.of(context).extension<ImageIconTheme>()!;
  final Color iconColor = imageIconTheme.backGroundColor!;
  final ShadowTheme shadowTheme = Theme.of(context).extension<ShadowTheme>()!;
  final BottomNavigationController ctr = Get.find();
  return Container(
    decoration: CustomBoxDecorations(context: context).shadowAll(),
    child: BottomNavigationBar(
      elevation: 10,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: AppIcons.unselectedHome(context, iconColor),
          activeIcon: AppIcons.home(context),
          label: homeTxt,
        ),
        BottomNavigationBarItem(
          icon: AppIcons.unselectedfavourite(context, iconColor),
          activeIcon: AppIcons.favourite(context),
          label: myWishlistTxt,
        ),
        BottomNavigationBarItem(
          icon: AppIcons.unselectedCheck(context, iconColor),
          activeIcon: AppIcons.check(context),
          label: hwAmazonTxt,
        ),
        BottomNavigationBarItem(
          icon: AppIcons.unselectedJoin(context, iconColor),
          activeIcon: AppIcons.join(context),
          label: joinUsTxt,
        ),
        BottomNavigationBarItem(
          icon: AppIcons.unselectedPerson(context, iconColor),
          activeIcon: AppIcons.person(context),
          label: accountTxt,
        ),
      ],
      currentIndex: ctr.selectedIndex,
      onTap: ctr.onItemTap,
    ),
  );
}
