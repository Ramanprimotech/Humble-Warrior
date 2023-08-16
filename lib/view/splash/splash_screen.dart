import 'dart:convert';

import 'package:humble_warrior/hw.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  VersionResponse data = VersionResponse();
  String version = "1.0.0";
  bool canNavigateInside = false;
  
  @override
  void initState() {
    startTime();
    print("object");
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    bool isDark = themeController.themeMode == ThemeMode.dark;
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder(
          builder: (BuildContext context, double? value, Widget? child) {
            return Transform.scale(scale: value, child: child);
          },
          tween: Tween(begin: .2, end: 1.5),
          duration: const Duration(seconds: 2),
          child: Image.asset(
            isDark
                ? ImagePathAssets.hwLogoDarkMode
                : ImagePathAssets.hwLogo,
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, navigationPage);
  }

  void navigationPage() async {
    await checkVersion(version: version).then((value) async {
      canNavigateInside = true;
      if (value == true) {
        SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
        sharedPreferences = await SharedPreferences.getInstance();
        bool? isLoggedIn = sharedPreferences.getBool("isLoggedIn");
        bool? isEntered = sharedPreferences.getBool("isEntered");

        /// Navigate to Login Page or Home Page
        if (isLoggedIn == true || isEntered == true) {
          Get.offNamed(AppRoutes.bottomNavigation);
        } else {
          Get.offNamed(AppRoutes.loginPage);
        }
      } else {
        print("_showDialog 111");
        _showDialog(context);
      }
    });
  }

  Future<bool?> checkVersion({required version}) async {
    bool isAllowed = false;
    try {
      Map payload = {"version": version};
      print("request 120 ${payload}");
      print("{Endpoints.token 120 ${Endpoints.token}");
      var response = await http.post(
        Uri.parse("http://112.196.54.37/Development/HW/wp-json/hwapi/version"),
        headers: {'Authorization': 'Bearer ${Endpoints.token}'},
        body: payload,
        // headers: {
        //   'Content-type': "application/json",
        //   'Authorization': 'Bearer ${Endpoints.token}'
        // },
      );
      if (response.statusCode == 200) {
        data = VersionResponse.fromJson(json.decode(response.body));
        print("status Code 2 ${response.statusCode}");
      } else {
        print("status Code 4 ${response.statusCode}");
        // return false;
      }

      if (data == null) {
        print("[Common.CheckVersion] - Received Null");
        return false;
      }
      data.success == true ? isAllowed = true : false;
      if (!isAllowed) {
        print("API[${data.version}] == APP[$version]");
      }
      return isAllowed;
    } catch (e, st) {
      print("[Common.CheckVersion 12] - Error $e\n$st");
      return false;
    }
  }
  void _showDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text("Partner Perks",),
            content: Container(
              height: 250,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const AppText("Wise-Rx", color: Colors.black, fontSize: 22),
                  AppText(
                    data.message ?? "",
                    // "We've just released a new update for the app which includes some great new features! To make sure you're getting the most out of the app, we recommend you update the app.",
                    color: Colors.black,
                    fontSize: 14,
                    maxLines: 6,
                    textAlign: TextAlign.center,
                    padding: const EdgeInsets.only(top: 18, bottom: 16),
                  ),
                ],
              ),
            )

          // const Text("Please install the updated version from TestFlight"),
          // actions: <Widget>[
          //    IconButton(
          //     icon:  const Text("OK"),
          //     onPressed: () {
          //       // Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }
}

class VersionResponse {
  bool? success;
  String? message;
  String? version;

  VersionResponse({this.success, this.message, this.version});

  @override
  String toString() {
    return 'VersionResponse{success: $success, message: $message, version: $version}';
  }

  VersionResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['version'] = this.version;
    return data;
  }
}

