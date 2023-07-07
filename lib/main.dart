import 'package:humble_warrior/hw.dart';

 final GlobalKey<NavigatorState>? mainNavigation = Get.nestedKey(1);
 final GlobalKey<NavigatorState>? wishNavigation = Get.nestedKey(2);
 final GlobalKey<NavigatorState>? homeNavigation = Get.nestedKey(3);
 final GlobalKey<NavigatorState>? accountNavigation = Get.nestedKey(4);

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    //  'This channel is used for important notifications.', // description
    importance: Importance.max,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

bool isLoggedIn = false;
Future<void> _messageHandler(RemoteMessage event) async {
  // NotificationController controller = Get.find();
  // controller.update(["badge"]);
  debugPrint("notification event ---- $event");
  "Message Received ${event.data}".log();
  Map data = event.data;
  try {
    if (data["url_to_redirect"] != "") {
      Future.delayed(Duration(seconds: 0),()async{
        if (data["post_id"] != "0") {
          ProductDetailsResponse productDetailsResponse = ProductDetailsResponse(
              id: int.parse(data["post_id"]!));
          Get.toNamed(AppRoutes.categoryItemDetail,id: 3,
              arguments: { "details" : productDetailsResponse});
          // Get.toNamed(AppRoutes.frontPageProductDetail,
          //     arguments: [productDetailsResponse]);
        }  else  if (!await launchUrl(
            Uri.parse(data["url_to_redirect"]),
            mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch');
        }
      });
    }
    else {
      Get.toNamed(AppRoutes.notification);
    }
  }catch(e, st){
    print(st);
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  isLoggedIn =
      await SharePreferenceData.getBoolValuesSF(spIsLogged) ?? false;
  await Firebase.initializeApp(
    // name: "humble-warrior",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  NotificationManager.initialize(flutterLocalNotificationsPlugin);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true, alert: true, sound: true);
  await Hive.initFlutter();
  Hive.registerAdapter(ProductDetailsResponseAdapter());
  Hive.registerAdapter(RecentSearchAdapter());
  Get.put(HiveService());
  Get.put(ThemeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  ThemeController themeController = Get.put(ThemeController());
  ValueNotifier theme = ValueNotifier(false);

  void getTheme() async {
    var themeMode = themeController.getThemeModeFromPreferences();
    theme.value = themeMode == ThemeMode.dark;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return ValueListenableBuilder(
            valueListenable: theme,
            builder: (BuildContext context, value, Widget? child) {
              return GetMaterialApp(
                // navigatorKey: mainNavigation,
                title: 'Humble Warrior',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: value ? ThemeMode.dark : ThemeMode.light,
                initialRoute: AppPages.initialRoute,
                getPages: AppPages.routes,
              );
            },
          );
        });
  }
}

dependencies() {
  Get.put(NotificationController(),permanent: true);
  Get.put(ThemeController());
  Get.put(HomeScreenController());
  Get.put(BottomNavigationController());
  Get.put(FrontPageDetailController());
  Get.put(MyAccountController());
  Get.put(WishListController());
}

class GlobalVariable {
  /// This global key is used in material app for navigation through firebase notifications.
  /// [navState] usage can be found in [notification_notifier.dart] file.
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();

}