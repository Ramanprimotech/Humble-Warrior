import 'dart:async';

import 'package:flutter/material.dart';
import 'package:humble_warrior/hw.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccountPopup extends StatefulWidget {
  const DeleteAccountPopup({super.key});

  @override
  createState() => _DeleteAccountPopupState();
}

class _DeleteAccountPopupState extends State<DeleteAccountPopup>
    with TickerProviderStateMixin {
  int _timer = 5;
  bool _showDeleteButton = false;
  bool _isLoading = false;

  ThemeController themeController = Get.find();
  MyAccountController controller = Get.find();

  @override
  void initState() {
    super.initState();
    // Start the timer
    _startTimer();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      if (_timer == 0) {
        setState(() {
          _showDeleteButton = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _timer--;
        });
      }
    });
  }

  Future<void> _handleDeleteButtonPressed() async {
    setState(() {
      _isLoading = true;
    });

    final bool isSubmitted = await controller.deleteMyAccount();

    if (isSubmitted) {
      setState(() {
        _isLoading = false;
      });
      // ignore: use_build_context_synchronously
      DialogHelper.showToast(context, "Account deleted successfully");
      Navigator.pop(context); // Close the popup
      Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.loginPage,
          (route) => false
      );
    } else {
      DialogHelper.showToast(context, "Some error occurred");
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context); // Close the popup
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: Image.asset(
          themeController.themeMode == ThemeMode.dark
              ? ImagePathAssets.hwLogoDarkMode
              : ImagePathAssets.hwLogo,
          width: Get.width * .40,
        ),
      ).centered().pLTRB(0, 20, 0, 10),
      title:  const Text(
          "Warning! You cannot recover your account once it is deleted. Are you sure?",
          style: TextStyle(
            fontSize: 16
          ),
        ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: _showDeleteButton,
              child : InkWell(
                onTap: _isLoading ? null : _handleDeleteButtonPressed,
                child: Container(
                    alignment: Alignment.center,
                    // width: 90,
                    height: 50,
                    width: 100,
                    padding: 10.ph,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3)]),
                    child: !_isLoading ? const AppText(
                      "Delete",
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ) : const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2
                    )
                ),
              )
            ),
            Visibility(
              visible: !_showDeleteButton,
              child: Text(
                'Wait: $_timer seconds',
              ),
            ),
            const SizedBox(width: 15,),
            TextButton(
              onPressed: () {
                _isLoading ? null : Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ],
    );
  }
}