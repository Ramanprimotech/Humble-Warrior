import 'dart:ui';
import 'package:humble_warrior/hw.dart';

final GlobalKey<NavigatorState>? mainNavigation = Get.nestedKey(1);
final GlobalKey<NavigatorState>? wishNavigation = Get.nestedKey(2);
final GlobalKey<NavigatorState>? webViewNavigation = Get.nestedKey(5);
final GlobalKey<NavigatorState>? homeNavigation = Get.nestedKey(3);
final GlobalKey<NavigatorState>? accountNavigation = Get.nestedKey(4);

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    //  'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

bool isLoggedIn = false;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  isLoggedIn =
      await SharePreferenceData.getBoolValuesSF(spIsLogged) ?? false;
  await Firebase.initializeApp(
    // name: "humble-warrior",
    options: DefaultFirebaseOptions.currentPlatform,
  );

/*  FlutterError.onError = (errorDetails) {
    // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    // If you wish to record a "non-fatal" exception, please remove the "fatal" parameter
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };*/

  FirebaseMessaging.onBackgroundMessage(NotificationManager.messageHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  NotificationManager.initialize(flutterLocalNotificationsPlugin);
  NotificationManager.messageListener();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true,
      alert: true,
      sound: true
  );

  FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
    NotificationManager.messageHandler(remoteMessage);
  });

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