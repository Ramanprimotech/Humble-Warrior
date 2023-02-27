import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/decorations.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
         child: Column(
           children: [
           _notificationButton(context),
           ],
         ),
       ),
    );
  }

  _notificationButton(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      // padding: 20.ps,
      margin: 15.pv,
      width: MediaQuery.of(Get.context!).size.width,
      decoration: CustomBoxDecorations().shadow(context: context),
      child: AppText(aboutDonnaTxt,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: AppColors.primary,
          textAlign: TextAlign.center),
    );
  }

}
