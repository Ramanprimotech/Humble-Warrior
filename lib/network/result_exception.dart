
import '../../utils/app_strings.dart';

class ResultStatusCheck {
  String? messageResponse;
  int? status;
  @override
  ResultStatusCheck({required this.status, this.messageResponse});

  String resultCheck() {
    print(status);
    switch (status) {
      case 400:
        return statusMessage(AppStrings.Er400);

      case 401:
        return statusMessage(AppStrings.Er401);

      case 403:
        return statusMessage(AppStrings.Er403);

      case 500:
        return statusMessage(AppStrings.Er500);

      default:
        return statusMessage(AppStrings.ErrDefault);
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
