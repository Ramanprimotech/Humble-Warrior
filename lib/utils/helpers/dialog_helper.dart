import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:humble_warrior/utils/extensions.dart';
import 'package:humble_warrior/utils/sizes/enumClass.dart';

import '../app_colors.dart';
import '../app_text.dart';
import '../button.dart';

abstract class DialogHelper {
  static final FToast _fToast = FToast();
  static bool _isToastInitialized = false;

  static void _initializeToast(BuildContext context) {
    if (_isToastInitialized) {
      return;
    }
    _fToast.init(context);
    _isToastInitialized = true;
  }

  static void showLoadingDialog({
    String label = 'Loading . . .',
    bool showLabel = true,
  }) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment:
                showLabel ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
               CircularProgressIndicator(color: AppColors.primary),
              if (showLabel) ...[
                const SizedBox(width: 16),
                AppText(label, fontSize: TextSizes.medium, maxLines: 1),
              ],
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Future<void> showConfirmationDialog({
    String title = "Are you sure?",
    String? description,
    required List<Button> actions,
  }) async {
    await Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              HeadingText(
                title,
                fontSize: 22,
                padding: const EdgeInsets.all(8),
              ),
              if (description != null) ...[
                AppText(
                  description,
                  maxLines: 3,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ],
              const SizedBox(height: 16),
              ...actions,
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showErrorDialog({
    String title = 'Error',
    String description = "Unknown error occurred",
    int? maxLines = 3,
  }) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: 8.pa.copyWith(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                  size: 50,
                ),
              ),
              8.sh,
              AppText(
                title,
                fontSize: TextSizes.normal,
                padding: 8.pl,
                fontWeight: FontWeight.bold,
              ),
              8.sh,
              AppText(
                description,
                maxLines: maxLines,
                padding: 8.pl,
              ),
              16.sh,
              const Button(
                label: 'Close',
                onTap: closeDialog,
                backgroundColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showToast(
    BuildContext context,
    String message, [
    IconData? icon,
  ]) {
    _initializeToast(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppColors.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            const Icon(Icons.add,color: AppColors.white,),
            // AppIcon(icon, color: AppColors.white),
            const SizedBox(width: 8),
          ],
          AppText(message, color: AppColors.white),
        ],
      ),
    );

    _fToast.showToast(child: toast);
  }

  static void closeDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
