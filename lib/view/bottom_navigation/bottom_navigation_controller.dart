import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/utils/routes/app_generate.dart';

List<ProductCategoryItem> productCategory = [];

class BottomNavigationController extends GetxController {
  final HomeScreenController controller = Get.find();

  RxBool userCheck = false.obs;
  bool isNavigated = false;

  DateTime? currentBackPressTime;
  final List<Widget> _navigationItems = [
    Navigator(
      key: homeNavigation,
      onGenerateRoute: (settings) => AppGenerate.generateRoutes(settings),
      initialRoute: AppRoutes.homePage,
    ),
    Navigator(
      key: wishNavigation,
      onGenerateRoute: (settings) => AppGenerate.generateRoutes(settings),
      initialRoute: AppRoutes.wishList,
    ),
    // const WishList(),
    const Placeholder(),
    const Placeholder(),
    Navigator(
      key: account,
      onGenerateRoute: (settings) => AppGenerate.generateRoutes(settings),
      initialRoute: AppRoutes.myAccount,
    ),
  ];

  List<Widget> get navigationItems => _navigationItems;

  int selectedIndex = 0;
  bool value = false;
  String? user;

  void onItemTap(int? index) async {
    CommonUtils.toCheckInternet(action: () async {
      if (index != 2 && index != 3) {
        selectedIndex = index!;
        if (index == 1) {
          var controller = Get.find<WishListController>();
          controller.getWishList();
        }
        // if (isNavigated) {
        //   isNavigated = false;
        //   Get.offNamedUntil(AppRoutes.bottomNavigation, (route) => false);
        // }
      } else {
        index == 2 ? amazon() : facebook();
      }
      update();
    });
  }

  ///--------------Check if user is logged in-------------///
  Future<void> getLoggedValue() async {
    value = await SharePreferenceData.getBoolValuesSF(spIsLogged) ?? false;
    user = await SharePreferenceData.getStringValuesSF(userEmail) ?? "";
  }

  Future<void> amazon() async {
    try {
      const url =
          'com.amazon.mobile.shopping://www.amazon.com/shop/influencer-1604f2b0'; // or add your URL here
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri,
          mode: LaunchMode.externalNonBrowserApplication)) {
        // throw Exception('Could not launch $uri');

        if (!await launchUrl(
            Uri.parse('https://www.amazon.com/shop/influencer-1604f2b0'),
            mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch $uri');
        }
      }
    } catch (e) {
      launchUrl(Uri.parse('https://www.amazon.com/shop/influencer-1604f2b0'),
          mode: LaunchMode.externalApplication);
    }
  }

  Future<void> facebook() async {
    const url =
        "fb://facewebmodal/f?href=https://www.facebook.com/groups/209617206226617";
    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri,
          mode: LaunchMode.externalNonBrowserApplication)) {
        if (!await launchUrl(
            Uri.parse('https://www.facebook.com/groups/209617206226617'),
            mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch $uri');
        }
      }
    } catch (e) {
      launchUrl(Uri.parse('https://www.facebook.com/groups/209617206226617'),
          mode: LaunchMode.externalApplication);
      print(e);
    }
  }

  @override
  void onInit() {
    getLoggedValue();
    FirebaseMessaging.instance.getToken().then((token) {});
    NotificationManager.messageListener();
    if (value != null) {
      userCheck.value = true;
    }
    super.onInit();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: exitApplicationTxt);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
