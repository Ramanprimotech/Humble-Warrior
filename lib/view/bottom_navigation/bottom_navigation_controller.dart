
import 'package:humble_warrior/view/wish_list/wish_list_screen.dart';


import 'package:humble_warrior/hw.dart';

class BottomNavigationController extends GetxController {
  final HomeScreenController controller = Get.find();

  RxBool userCheck = false.obs;

  DateTime? currentBackPressTime;
  final List<Widget> _navigationItems = [
    const HomeScreen(),
    const WishList(),
    /// Amazon view
    const WebViewScreenWidget(
        title: myAmazonTxt,
        key: Key(myAmazonTxt),
        url: "https://www.amazon.com/shop/influencer-1604f2b0"),
    /// Facebook View
    const WebViewScreenWidget(
      title: joinUsTxt,
      url: "https://www.facebook.com/groups/209617206226617",
      key: Key(joinUsTxt),
    ),
    const MyAccount(),
  ];

  List<Widget> get navigationItems => _navigationItems;

  int selectedIndex = 0;
  bool value = false;
  String? user;

  void onItemTap(int? index) {
    selectedIndex = index!;
    update();
  }

  Future<void> getLoggedValue() async {
    value = await SharePreferenceData.getBoolValuesSF(spIsLogged) ?? false;
    user = await SharePreferenceData.getStringValuesSF(userEmail) ?? "";
    debugPrint("Logged Value ---- $value --- user --- $user");
  }

  @override
  void onInit() {
    getLoggedValue();
    if (value != null) {
      userCheck.value = true;
    }
    super.onInit();
  }

  Future<bool> onWillPop() {
    // controller.unfocusNode();
    // if (controller.focusNode.hasFocus) {
    //   controller.unfocusNode();
    //   return Future.value(false);
    // }
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press again to exit application");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
