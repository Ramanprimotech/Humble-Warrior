import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:humble_warrior/modals/hive_modal/product_details_response.dart';
import 'package:humble_warrior/modals/hive_modal/recent_search_model.dart';
import 'package:humble_warrior/services/hive_storage_service.dart';
import 'package:humble_warrior/services/notification_manager.dart';
import 'package:humble_warrior/utils/app_themes/app_theme.dart';
import 'package:humble_warrior/utils/app_themes/app_theme_controller.dart';

import 'firebase_options.dart';
import 'utils/routes/app_pages.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    //  'This channel is used for important notifications.', // description
    importance: Importance.max,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _messageHandler(RemoteMessage message) async {
  debugPrint('background message ${message.notification!.body}');
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
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
  ValueNotifier theme = ValueNotifier(ThemeMode.system == ThemeMode.dark);

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

class GlobalVariable {
  /// This global key is used in material app for navigation through firebase notifications.
  /// [navState] usage can be found in [notification_notifier.dart] file.
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
}
