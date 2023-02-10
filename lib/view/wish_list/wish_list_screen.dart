import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:humble_warrior/view/wish_list/wish_list_controller.dart';

class WishList extends StatelessWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WishListController controller = Get.find();
    return Scaffold(
       body: Container(
         child: Center(
         child: controller.value==false?Container(
           height: 150,
               padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
                 color: Colors.white,
                 boxShadow: [BoxShadow(color: Colors.grey,spreadRadius: 2,blurRadius: 2,
                     offset: Offset(0,4))],
               ),
               child: Column(children: [
                 AppText('Please Login for access this feature.'),
                 20.sh,
                 ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     elevation: 5,
                     fixedSize: const Size(120, 35),
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10)),
                     backgroundColor: AppColors.primary,
                   ),
                   onPressed: () {
                     Get.offAllNamed(AppRoutes.loginPage);
                   },
                   child: const AppText('Go to Login.', color: Colors.white,fontWeight: FontWeight.bold),
                 ),
               ]),
             ):AppText('My Favourite'),
         ),
       ),
    );
  }
}
