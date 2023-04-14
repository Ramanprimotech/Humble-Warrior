import 'package:humble_warrior/hw.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    //  'This channel is used for important notifications.', // description
    importance: Importance.max,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

bool isLoggedIn = false;
Future<void> _messageHandler(RemoteMessage message) async {
  debugPrint('background message ${message.notification!.body}');
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

   isLoggedIn =
      await SharePreferenceData.getBoolValuesSF(spIsLogged) ?? false;
  await Firebase.initializeApp(
    name: "humble-warrior",
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
                navigatorKey: GlobalVariable.navState,
                title: 'Flutter Demo',
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
  Get.put(NotificationController());
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
