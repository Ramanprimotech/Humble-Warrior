import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/services/notification_manager.dart';
import 'package:humble_warrior/view/wish_list/wish_list_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomNavigationController extends GetxController {
  final HomeScreenController controller = Get.find();

  RxBool userCheck = false.obs;
  bool isNavigated = false;

  DateTime? currentBackPressTime;
  final List<Widget> _navigationItems = [
    const HomeScreen(),
    const WishList(),
    Placeholder(),
    Placeholder(),

    // /// Amazon view
    // const WebViewScreenWidget(
    //     title: hwAmazonTxt,
    //     key: Key(hwAmazonTxt),
    //     url: "https://www.amazon.com/shop/influencer-1604f2b0"),
    //
    // /// Facebook View
    // const WebViewScreenWidget(
    //   title: joinUsTxt,
    //   url: "https://www.facebook.com/groups/209617206226617",
    //   key: Key(joinUsTxt),
    // ),
    const MyAccount(),
  ];

  List<Widget> get navigationItems => _navigationItems;

  int selectedIndex = 0;
  bool value = false;
  String? user;

  void onItemTap(int? index) async {
    if (index != 2 && index != 3) {
      selectedIndex = index!;
      if (index == 1) {
        var controller = Get.find<WishListController>();
        controller.getWishList();
      }
      if (isNavigated) {
        isNavigated = false;
        Get.offNamedUntil(AppRoutes.bottomNavigation, (route) => false);
      }
    } else {
      index == 2 ? amazon() : facebook();
    }
    update();
  }

  ///--------------Check if user is logged in-------------///
  Future<void> getLoggedValue() async {
    value = await SharePreferenceData.getBoolValuesSF(spIsLogged) ?? false;
    user = await SharePreferenceData.getStringValuesSF(userEmail) ?? "";
  }

  Future<void> amazon() async {
    // await CommonUtils().urlLauncher(
    //     url:
    //         'com.amazon.mobile.shopping://www.amazon.in/shop/influencer-1604f2b0',
    //     title: "The Humble Warrior");
    const url =
        'com.amazon.mobile.shopping://www.amazon.in/shop/influencer-1604f2b0'; // or add your URL here
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
    // await launchUrl(Uri.parse(url),
    //     mode: LaunchMode.externalNonBrowserApplication);
  }

  Future<void> facebook() async {
    const url =
        "fb://facewebmodal/f?href=https://www.facebook.com/groups/209617206226617";
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
    // await launchUrl(Uri.parse(url),
    //     mode: LaunchMode.externalNonBrowserApplication);
  }

  @override
  void onInit() {
    getLoggedValue();
    FirebaseMessaging.instance.getToken().then((token) {
      debugPrint("token ---- $token");
    });
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
      Fluttertoast.showToast(msg: "Press again to exit application");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
