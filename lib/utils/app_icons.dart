import 'package:humble_warrior/hw.dart';

class AppIcons {
  static Image favourite(BuildContext context) => Image.asset(
        ImagePathAssets.heartIcon,
        height: 20,
        color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      );

  static Image unselectedfavourite(BuildContext context, Color color) =>
      Image.asset(
        ImagePathAssets.heartIcon,
        height: 20,
        color: color,
      );

  static Image check(BuildContext context) => Image.asset(
        ImagePathAssets.amazonIcon,
        height: 22,
        color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      );

  static Image unselectedCheck(BuildContext context, Color color) =>
      Image.asset(
        ImagePathAssets.amazonIcon,
        height: 20,
        color: color,
      );

  static Image home(BuildContext context) => Image.asset(
        ImagePathAssets.homeIcon,
        height: 20,
        color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      );

  static Image unselectedHome(BuildContext context, Color color) => Image.asset(
        ImagePathAssets.homeIcon,
        height: 20,
        color: color,
      );

  static Image notification(BuildContext context) => Image.asset(
        ImagePathAssets.notificationIcon,
        height: 40,
        width: 30,
      );

  static Image join(BuildContext context) => Image.asset(
        ImagePathAssets.facebookIcon,
        height: 20,
        color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      );

  static Image unselectedJoin(BuildContext context, Color color) => Image.asset(
        ImagePathAssets.facebookIcon,
        height: 20,
        color: color,
      );

  static Image person(BuildContext context) => Image.asset(
        ImagePathAssets.personIcon,
        height: 20,
        color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      );

  static Image unselectedPerson(BuildContext context, Color color) =>
      Image.asset(
        ImagePathAssets.personIcon,
        height: 20,
        color: color,
      );

  //<=========== Bottom Navigation

  //Action Bar ===========>

  static Icon share({iconColor = Colors.black}) => Icon(
        Icons.share,
        size: Dimens.mediumIcon,
        color: iconColor,
      );

  static Icon filter({Color? iconColor, double size = 24}) => Icon(
        Icons.sort,
        color: iconColor,
        size: size,
      );

  //<=========Action Bar

  //Account Icons===========>

  static Icon next({Color? iconColor}) => Icon(
        Icons.arrow_forward_ios,
        color: iconColor,
      );

  static Icon backArrrowIos({Color? iconColor}) => Icon(
        Icons.arrow_back_ios,
        color:
            iconColor ?? Theme.of(Get.context!).textTheme.displaySmall!.color!,
      );

  static IconButton IosBackIcon({Color? iconColor, Function()? onPress}) =>
      IconButton(
        padding: 20.pl,
        icon: backArrrowIos(),
        onPressed: onPress ??
            () {
              Get.back();
            },
      );

  /// Account Icons

  static Icon heart({Color iconColor = Colors.black, double? size}) => Icon(
        Icons.favorite_outlined,
        color: iconColor,
        size: size ?? Dimens.largeIcon,
      );

  static Icon bookmarks({Color iconColor = Colors.black}) =>
      Icon(Icons.bookmarks, color: iconColor);
}

class Heart extends StatefulWidget {
  Heart(
      {super.key,
      this.color = Colors.black,
      required this.id,
      required this.item,
      this.size,
      this.isSelected});

  final double? size;
  bool? isSelected = false;
  Color? color;
  String id;
  ProductDetailsResponse item;
  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    HiveService service = Get.find<HiveService>();
    Box<ProductDetailsResponse> box = service.box;
    // List<dynamic> keys = service.findKey(widget.item.id.toString());
    // print(keys);

    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, box, child) {
        return GestureDetector(
          key: widget.key,
          onTap: () async {
            bool value =
                await SharePreferenceData.getBoolValuesSF(spIsLogged) ?? false;
            if (value) {
              service.favourite(item: widget.item);
            } else {
              if (context.mounted) {
                DialogHelper.showConfirmationDialog(
                    message: loginWishTxt,
                    actionLabel: login,
                    action: () {
                      Get.toNamed(AppRoutes.loginPage);
                    },
                    context: context);
              }
            }
          },
          child: Icon(
            Icons.favorite_outlined,
            color: isLoggedIn && service.hasItem(widget.item.id.toString())
                ? Colors.red
                : widget.color,
            size: widget.size ?? Dimens.largeIcon,
          ),
        );
      },
    );
  }
}
