import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'utils/routes/app_pages.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder:(BuildContext context, Widget? child){
      return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        initialRoute: AppPages.initialRoute,
        getPages: AppPages.routes,
      );
    });

  }
}


