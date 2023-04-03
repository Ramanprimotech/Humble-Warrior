import 'dart:developer';
import 'package:intl/intl.dart';

import '../modals/requests/token_model_request.dart';
import '../network/api_call.dart';

import 'package:humble_warrior/hw.dart';

class TokenManager {
  final Function() onTokenGenerate;
  final Function() onTokenEror;
  TokenManager({required this.onTokenGenerate, required this.onTokenEror});
  static const String _TOKEN_KEY = 'token';
  static const String _TOKEN_EXPIRY_KEY = 'token_expire';
  static const int _TOKEN_EXPIRY_DURATION =
      24 * 60 * 60 * 1000; // 24 hours in milliseconds

  SharedPreferences? _prefs;
  String? _token;
  Timer? _timer;
  String? _tokenExpirationDuration;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs!.getString(_TOKEN_KEY);
    _tokenExpirationDuration = _prefs!.getString(_TOKEN_EXPIRY_KEY);

    log(_token.toString(), name: " Token");
    if (_token == null) {
      log("Toke New", name: "New Token");
      // token doesn't exist, so generate a new one
      await _generateToken().then((value) {
        if (value) {
          _startTimer();
        } else {
          onTokenEror();
        }
      });
    } else {
      log("Toke Old", name: "Old Token");
      Endpoints.token = _token!;
      _startTimer();
    }

    // set up timer to update token after 24 hours
  }

  // String getToken() {
  //   return _token;
  // }

  void _startTimer() async {
    // cancel existing timer if it exists
    _timer?.cancel();
    _timer = Timer(Duration(seconds: nextRefresh()), () async {
      // generate a new token and save it to SharedPreferences
      await _generateToken().then((value) {
        if (value) {
          _startTimer();
        } else {
          onTokenEror();
        }
      });
      // start the timer again
    });
  }

  int nextRefresh() {
    ///Current date
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime currentDateTime = DateTime.now();

    ///Expiration time
    _tokenExpirationDuration = _tokenExpirationDuration!.replaceAll("/", "-");
    _tokenExpirationDuration = dateFormat.format(
        DateFormat('MM-dd-yyyy HH:mm:ss').parse(_tokenExpirationDuration!));
    DateTime expiration = dateFormat.parse(_tokenExpirationDuration!);
    int refreshTime = expiration.difference(currentDateTime).inSeconds;

    log(expiration.toString(), name: "Token Expiration Date");
    log(refreshTime.toString(), name: "Token Expiration In Seconds");

    return refreshTime;
  }

  Future<bool> _generateToken() async {
    TokenRequestModel tokenRequestModel = TokenRequestModel(userid: "4"

        // username: "info@newjerseymultimedia.com",
        // password: "JtB@zCajal87@7MVXjzfyxOd"
        );
    await CallAPI.generateToken(payload: tokenRequestModel).then((value) {
      if (value.token == null) {
        DialogHelper.showToast(
            Get.context!, "Unable to generate authentication token");
        return false;
      } else {
        String token = value.token!;
        String tokenExpire = value.tokenExpire!;
        log("${value.token}", name: "Token API");
        _token = value.token;
        _tokenExpirationDuration = value.tokenExpire;

        Endpoints.token = value.token.toString();
        _prefs!.setString(_TOKEN_KEY, token);
        _prefs!.setString(_TOKEN_EXPIRY_KEY, tokenExpire);
        log(value.token.toString());
      }
    });
    return true;
  }
}
