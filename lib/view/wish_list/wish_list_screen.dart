import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/modals/response/donna_deals_response.dart';
import 'package:humble_warrior/modals/response/donna_favourite_response_model.dart';
import 'package:humble_warrior/modals/response/front_page_response_model.dart';
import 'package:humble_warrior/utils/app_icons.dart';
import 'package:humble_warrior/utils/app_strings.dart';
import 'package:humble_warrior/utils/app_text.dart';
import 'package:humble_warrior/utils/common/common_widgets.dart';
import 'package:humble_warrior/utils/decorations.dart';
import 'package:humble_warrior/utils/helpers/extensions.dart';
import 'package:humble_warrior/utils/routes/app_routes.dart';
import 'package:humble_warrior/utils/theme_extention/custom_notice_theme_extention.dart';
import 'package:humble_warrior/view/wish_list/wish_list_controller.dart';
import 'package:humble_warrior/view/wish_list/wish_list_widgets/wish_list_card_selector.dart';

class WishList extends StatelessWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WishListController controller = Get.find();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CommonWidgets.titleBar(context, title: myWishlistTxt,fontSize: 20,backIcon: false),
            Expanded(
              child: Center(
                child: controller.value == false
                    ? loginFirst(context)
                    : ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          dynamic details = modelReturn(index);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: WishListCardSelector(
                              details: details,
                              index: index,
                              context: context,
                            ),
                          );
                        },
                        itemCount: 20,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }




  Widget loginFirst(context) {
    return CommonWidgets.errorAPI(
        height: 150,
        buttonTitle: gotoLoginTxt,
        errorText: accessingMsgTxt,
        context: context,
        onPress: (){
          Get.offAllNamed(AppRoutes.loginPage);
        });
    /*Container(
      height: 150,
      padding: 20.ps,
      decoration: CustomBoxDecorations().shadow(context: context),
      child: Column(children: [
        AppText(accessingMsgTxt,
            color: dialogueThemeExtention.textColor, fontSize: 20),
        20.sh,
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            // fixedSize: const Size(, 35),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: dialogueThemeExtention.buttonColor,
          ),
          onPressed: () {
            Get.offAllNamed(AppRoutes.loginPage);
          },
          child: const AppText(gotoLoginTxt,
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ]),
    );*/
  }
}

modelReturn(int index) {
  int type = index % 3;

  if (type == 0) {
    return DonnaDealsDetails(
        url:
            "https://humblewarrior.com/wp-content/uploads/2023/02/Screenshot-2023-02-27-at-8.14.10-AM-300x300.png",
        shopUrl: "https://shop.humblewarrior.com/amazon/m36V",
        couponCode: "asdasdsdsd",
        dealName: "CAT CONDO SAVINGS!");
  }
  if (type == 1) {
    return DonnaFavouriteDetails(
      url:
          "https://humblewarrior.com/wp-content/uploads/2023/01/Table-Top-Fire-Pit-Bowl-01-12-23-LIVE-PIC-SMFT.jpg",
      productName: "Table-Top-Fire-Pit-Bowl",
    );
  }

  return FrontPageDetails(
      url:
          "https://humblewarrior.com/wp-content/uploads/2022/11/Screen-Shot-2022-11-19-at-7.40.27-PM-258x155.png",
      productName: "Vine Oh! for the Holidays!",
      ribbonColor: "FFFFFF",
      ribbonName: "Vine Oh! Ho Ho!");
}
