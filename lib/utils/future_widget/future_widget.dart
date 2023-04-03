import 'package:flutter/material.dart';
import 'package:humble_warrior/utils/future_widget/abstract_future_widget.dart';

class FutureWidget<T> {
  Widget builder(
      {required FutureAPI<T> futureWidgets,
      required Future<T> future,
      required BuildContext context}) {
    return FutureBuilder<T>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return futureWidgets.waiting();
          }
          if (snapshot.hasError) {
            return futureWidgets.error(error: snapshot.error);
          }
          return futureWidgets.success(data: snapshot.data);
        });
  }
}
