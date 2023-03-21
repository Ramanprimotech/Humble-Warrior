import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future initialize() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    /// Android Notification Set Up
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    /// IOS Notification SetUP

    const DarwinInitializationSettings iOSSettings =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    /// Local Notification Initialization
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iOSSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: doSomething(),
    );
  }

  static Future showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AppleNotification? apple = message.notification?.apple;
    print("Message Recieved ${notification!.title}");

    // if (notification != null ) {
    //   _flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       "${notification.title} inner ",
    //       notification.body,
    //       const NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           "default_notification_channel_id",
    //           "channel",
    //           icon: "@mipmap/ic_launcher",
    //
    //           // other properties...
    //         ),
    //       ));
    // }

    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
      "default_notification_channel_id",
      "channel",
      enableLights: true,
      enableVibration: true,
      priority: Priority.high,
      importance: Importance.max,
      icon: "@mipmap/ic_launcher",
      styleInformation: MediaStyleInformation(
        htmlFormatContent: true,
        htmlFormatTitle: true,
      ),
      playSound: true,
    );

    await _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: androidDetails,
        ));

    // Get.snackbar(
    //   "${notification.title}",
    //   "${notification.body}",
    //   colorText: AppColors.primary,
    //   icon: Icon(Icons.flutter_dash),
    //   backgroundColor: AppColors.white,
    // );
  }
}
