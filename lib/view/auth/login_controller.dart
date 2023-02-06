import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  /// Click
  Function onClickFunction({required OnClick action,required BuildContext context}) {
    Map<OnClick, void Function()> actions = {
      /// Click  facebook
      OnClick.facebook: () async {

      },

      /// Click Google
      OnClick.google: () async {

      },


      /// Click apple
      OnClick.apple: () async {

      },


    };

    Function act = actions[action]!;
    return act;
  }
}
enum OnClick { facebook, google,  apple }