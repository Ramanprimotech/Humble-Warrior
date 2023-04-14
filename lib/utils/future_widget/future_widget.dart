import 'package:flutter/material.dart';
import 'package:humble_warrior/utils/future_widget/abstract_future_widget.dart';

class FutureWidget<T> {
  Widget builder(
      {required FutureAPI<T> futureWidgets,
      required Future<T> future,
      required BuildContext context,
      required bool checkInternet,
        bool? waiting = true,
      }) {
    return FutureBuilder<T>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return waiting==false?SizedBox():futureWidgets.waiting();
          }
          if (snapshot.hasError) {
            return checkInternet==true?futureWidgets.error(error: snapshot.error):SizedBox();
          }
          return futureWidgets.success(data: snapshot.data);
        });
  }
}
