import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_colors.dart';

class ToastLogger{

  // Loggers ===========>
  void apiLoggerRequest(String text, String name, Object? error) {
    log(text, time: DateTime.now(), name: "Request==> $name", error: error);
  }

  void apiLoggerResponse(String text, String name, Object? error) {
    log(text, time: DateTime.now(), name: "Response==> $name", error: error);
  }

  void testLoggerResponse(String text, String name, Object? error) {
    log(text, time: DateTime.now(), name: "Debug==> $name", error: error);
  }

  void testCase(String text, String name, Object? error) {
    log(text, time: DateTime.now(), name: "Test Case==> $name", error: error);
  }

  void apiLoggerError(String text, String name, Object? error) {
    log(text, time: DateTime.now(), name: "Error==> $name", error: error);
    toastError(error.toString());
  }

  // Toasts ===========>
  void toastError(String text) {
    Get.snackbar(text, "",
        icon: const Icon(Icons.error, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: AppColors.purple);
  }

  void toastFail(String text) {
    Get.snackbar(text, "",
        // icon: const Icon(Icons.warning_amber_outlined, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: AppColors.purple);
  }

  void toastSucess(String text) {
    Get.snackbar(text, "",
        // icon: const Icon(Icons.error, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: AppColors.purple);
  }
}