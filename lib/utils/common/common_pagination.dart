import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaginationWidget extends StatelessWidget {
  final RxBool apiBool;
  final Function api;
  final Function update;
  final RxInt length;
  final RxInt totalRecords;
  final ScrollController scrollController;
  final Widget child;

  const PaginationWidget({
    super.key,
    required this.apiBool,
    required this.api,
    required this.update,
    required this.scrollController,
    required this.child,
    required this.totalRecords,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          log("$length   $totalRecords", name: "Pagination");
          if (length.value <= totalRecords.value) {
            if (apiBool.value == false) {
              apiBool.value = true;
              update();
              Future.delayed(Duration(milliseconds: 10), () {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                );
              });

              api();
            }
          }
        }
        return true;
      },
      child: child,
    );
  }
}
