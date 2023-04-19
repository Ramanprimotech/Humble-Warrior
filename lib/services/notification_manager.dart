import 'dart:convert';

import 'package:humble_warrior/hw.dart';


class NotificationManager {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    /// Android Notification Set Up
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

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
      onDidReceiveNotificationResponse: (NotificationResponse response) {
      try {
        "Noti ${response.input}".log();
        "Noti ${response.payload is Map}".log();
        Map data = jsonDecode(response.payload!);
        "adsaddasdadsdsa".log();
        if (data["url_to_redirect"] != "") {
          "NOti kl${data["url_to_redirect"]}".log();

          Future.delayed(Duration(seconds: 0),()async{

         if (data["post_id"] != "0") {
          "Noti Id ${data["post_id"]}".log();
          ProductDetailsResponse productDetailsResponse = ProductDetailsResponse(
              id: int.parse(data["post_id"]!));
          Get.toNamed(AppRoutes.frontPageProductDetail,
              arguments: [productDetailsResponse]);
        }  else  if (!await launchUrl(
             Uri.parse(data["url_to_redirect"]),
             mode: LaunchMode.externalApplication)) {
           Get.toNamed(AppRoutes.notification);
         }
          });
        }
         else {
          Get.toNamed(AppRoutes.notification);
        }
      }catch(e, st){
        print(st);
      }


      },
    );
  }

  ///  Notification Listener
  static void messageListener() {

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

message.data.toString().log();

      if (android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification!.title??"",
            notification!.body??"",
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: "@mipmap/ic_launcher",

                // other properties...
              ),
            ),
           payload : jsonEncode( message.data),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {

      debugPrint("notification event ---- $event");
      "Message Received ${event.data}".log();


      Get.toNamed(AppRoutes.notification);

    });
  }
}
