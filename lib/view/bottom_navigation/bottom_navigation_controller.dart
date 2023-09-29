import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/utils/routes/app_generate.dart';

List<ProductCategoryItem> productCategory = [];

RxString currentHomeRoute = "".obs;
RxString currentWishRoute = "".obs;
RxString currentAccountRoute = "".obs;
RxString webViewAccountRoute = "".obs;
final MyAppRouteObserver homeRouteObserver = MyAppRouteObserver(currentRouteName: currentHomeRoute);
final MyAppRouteObserver accountRouteObserver = MyAppRouteObserver(currentRouteName: currentAccountRoute);
final MyAppRouteObserver wishRouteObserver = MyAppRouteObserver(currentRouteName: currentWishRoute);
final MyAppRouteObserver webViewRouteObserver = MyAppRouteObserver(currentRouteName: webViewAccountRoute);
class BottomNavigationController extends GetxController {
  final HomeScreenController controller = Get.find();

  RxBool userCheck = false.obs;
  bool isNavigated = false;

  DateTime? currentBackPressTime;
  final List<Widget> _navigationItems = [
    Navigator(
      key: homeNavigation,
      observers: [homeRouteObserver],
      onGenerateRoute: (settings) => AppGenerate.generateRoutes(settings),
      initialRoute: AppRoutes.homePage,
    ),
    Navigator(
      key: wishNavigation,
      observers: [wishRouteObserver],
      onGenerateRoute: (settings) => AppGenerate.generateRoutes(settings),
      initialRoute: AppRoutes.wishList,
    ),
    // const WishList(),
    Navigator(
      key: webViewNavigation,
      observers: [webViewRouteObserver],
      onGenerateRoute: (settings) => AppGenerate.generateRoutes(settings),
      initialRoute: AppRoutes.webView,
    ),
    const Placeholder(),
    Navigator(
      key: accountNavigation,
      observers: [accountRouteObserver
      ],
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
      if (index != 3) {
        selectedIndex = index!;
        if (index == 1) {
          var controller = Get.find<WishListController>();
          controller.getWishList();
        }
        if (selectedIndex == index) {
          if (index == 0) {
            homeNavigation!.currentState?.popUntil((route) => route.isFirst);
          }
          if (index == 1) {
            wishNavigation!.currentState?.popUntil((route) => route.isFirst);
          }
          if (index == 2) {
            webViewNavigation!.currentState?.popUntil((route) => route.isFirst);
          }
          if (index == 4) {
            accountNavigation!.currentState?.popUntil((route) => route.isFirst);
          }
        }
        // if (isNavigated) {
        //   isNavigated = false;
        //   Get.offNamedUntil(AppRoutes.bottomNavigation, (route) => false);
        // }
      } else {
        facebook();
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
    // FirebaseMessaging.instance.getToken().then((token) {});
    // NotificationManager.messageListener();
    if (value != null) {
      userCheck.value = true;
    }
    super.onInit();
  }

  Future<bool> onWillPop() {
    if(selectedIndex == 0){
      if(currentHomeRoute.value != AppRoutes.homePage){
        Get.back(id: 3);
        return Future.value(false);
      }
    }
    if(selectedIndex == 1){
      if(currentWishRoute.value != AppRoutes.wishList){
        Get.back(id: 2);
        return Future.value(false);
      }
    }
    if(selectedIndex == 2){
      if(webViewAccountRoute.value != AppRoutes.webView){
        Get.back(id: 2);
        return Future.value(false);
      }
    }
    if(selectedIndex == 4){
      if(currentAccountRoute.value != AppRoutes.myAccount){
        Get.back(id: 4);
        return Future.value(false);
      }
    }
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

class MyAppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  RxString currentRouteName;
  MyAppRouteObserver({required this.currentRouteName});

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    currentRouteName.value = route.settings.name??"";
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    currentRouteName.value = previousRoute?.settings.name??"";

  }
}