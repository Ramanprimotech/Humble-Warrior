import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_themes/app_theme.dart';
import 'package:humble_warrior/utils/app_themes/app_theme_controller.dart';

import 'firebase_options.dart';
import 'utils/routes/app_pages.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
