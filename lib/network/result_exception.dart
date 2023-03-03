
import 'package:flutter/cupertino.dart';

import '../../utils/app_strings.dart';

class ResultStatusCheck {
  String? messageResponse;
  int? status;
  @override
  ResultStatusCheck({required this.status, this.messageResponse});

  String resultCheck() {
    debugPrint("$status");
    switch (status) {
      case 400:
        return statusMessage(AppStrings.er_400);

      case 401:
        return statusMessage(AppStrings.er401);

      case 403:
        return statusMessage(AppStrings.er403);

      case 500:
        return statusMessage(AppStrings.er500);

      default:
        return statusMessage(AppStrings.errDefault);
    }
  }

  String statusMessage(String text) {
    if (messageResponse != null) {
      return messageResponse!;
    } else {
      return text;
    }
  }
}
