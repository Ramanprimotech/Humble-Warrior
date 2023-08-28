import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:humble_warrior/hw.dart';
import 'package:path_provider/path_provider.dart';


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
        onDidReceiveNotificationResponse: _handleNotificationResponse,
        onDidReceiveBackgroundNotificationResponse: _handleNotificationResponse
    );
  }

  static _handleNotificationResponse(NotificationResponse response){
    NotificationController controller = Get.find();
    controller.update(["badge"]);
    try {
      Map data = jsonDecode(response.payload!);
      if (data["url_to_redirect"] != "") {

        Future.delayed(const Duration(seconds: 0),()async{

          if (data["post_id"] != "0") {
            ProductDetailsResponse productDetailsResponse = ProductDetailsResponse(
                id: int.parse(data["post_id"]!));
            // Get.toNamed(AppRoutes.frontPageProductDetail,
            //     arguments: [productDetailsResponse]);
            Get.toNamed(AppRoutes.categoryItemDetail,id: 3,
                arguments: { "details" :   productDetailsResponse});
          }  else  if (!await launchUrl(
              Uri.parse(data["url_to_redirect"]),
              mode: LaunchMode.externalApplication)) {
            throw Exception('Could not launch');
          }
        });
      }
      else {
        launchUrl( Uri.parse(data["url_to_redirect"]));
      }
    }catch(e, st){
      print(st);
    }
  }

  ///  Notification Listener
  static void messageListener() {

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      // NotificationController controller = Get.find();
      // controller.update(["badge"]);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? apple = message.notification?.apple;


      if(apple !=null){
        apple.imageUrl!.log();
        "apple".log();
        String? path = await _downloadAndSavePicture(apple.imageUrl, "fileName.png");
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification!.title??"",
          notification.body??"",
          NotificationDetails(
            iOS: DarwinNotificationDetails(
              attachments: <DarwinNotificationAttachment>[
                DarwinNotificationAttachment(
                  path!,
                  identifier: 'image',
                ),
              ],
            ),
          ),
          payload : jsonEncode( message.data),
        );
      }

      if(android!=null){
        android.imageUrl!.log();
        "adnroid".log();
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification!.title??"",
          notification.body??"",
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
  }

  static Future<void> messageHandler(RemoteMessage event) async {
    Map data = event.data;
    try {
      if (data["url_to_redirect"] != "") {
        if (data["post_id"] != "0") {
          ProductDetailsResponse productDetailsResponse = ProductDetailsResponse(
              id: int.parse(data["post_id"]!));
          Get.toNamed(AppRoutes.categoryItemDetail, id: 3,
              arguments: { "details": productDetailsResponse});
        } else if (!await launchUrl(
            Uri.parse(data["url_to_redirect"]),
            mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch');
        }else{
          Get.toNamed(AppRoutes.notification);
        }
      }
      else {
        Get.toNamed(AppRoutes.notification);
      }
    }catch(e, st){
      print("Remote message exception $e");
      Get.toNamed(AppRoutes.notification);
    }
  }
}

Future<String?> _downloadAndSavePicture(String? url, String fileName) async {
  if (url == null) return null;
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final http.Response response = await http.get(Uri.parse(url));
  final File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}