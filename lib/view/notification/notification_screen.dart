import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/app_colors.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/decorations.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         body: Container(
           // margin: 20.ph,
           child: Column(
             children: [
             _notificationButton(context),
               Expanded(
                 child: ListView.separated(
                   // shrinkWrap: true,
                   padding: 15.ph,
                   scrollDirection: Axis.vertical,
                   itemBuilder: (context, index) {
                   return notificationContainer(context);
                 },
                   itemCount: 15,
                   separatorBuilder: (BuildContext context, int index) {
                   return 20.sh;
                   },
                 ),
               ),
               // notificationContainer(),
             ],
           ),
         ),
      ),
    );
  }

  _notificationButton(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: MediaQuery.of(Get.context!).size.width,
      decoration: CustomBoxDecorations().shadow(context: context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).textTheme.displaySmall!.color!),
            onPressed: (){
            Get.back();
            },
          ),
          AppText(notificationsTxt,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.primary,
              textAlign: TextAlign.center),
          SizedBox(),
        ],
      ),
    );
  }

  notificationContainer(context){
    return Container(
      width: Get.width,
      height: 130,
      decoration: CustomBoxDecorations().shadow(context: context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      notificationImg(),
                      notificationDetails(),
                    ]),
                dayButton(),
              ],
            ),
          ),

        ],
      ),
    );
  }

  notificationImg(){
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
      child: CommonWidgets.networkImage(
        imageUrl: "https://humblewarrior.com/wp-content/uploads/2022/11/Facetune_20-06-2022-06-51-2.jpg",
        alignment: Alignment.topCenter,
        width: Get.width/3.5,
        fit: BoxFit.cover,
      ),
    );
  }

  notificationDetails(){
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  // top: Radius.circular(10),
                )),
            child: AppText(
              // homeOptions.categoryName!.toUpperCase(),
              donnaFavouriteDealTxt.toUpperCase(),
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 11,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5,left: 15),
            child: AppText("Style And Savings"*3,
              fontWeight: FontWeight.bold,
              maxLines: 2,
              fontSize: 14,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15,right: 10,top: 5),
            child: AppText("These cuties were tough to photograph and honestly my picture doesn't to do justice."*2,
              fontSize: 11, maxLines: 2,
            ),
          ),
        ],),

    );
  }

  dayButton(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      padding: const EdgeInsets.only(left: 10,right: 10, bottom: 2),
      decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8)),
      child: AppText(
        // homeOptions.categoryName!.toUpperCase(),
        // "Today",
        "Yesterday",
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 12,
      ),
    );
  }

}
