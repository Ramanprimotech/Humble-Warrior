import 'package:humble_warrior/hw.dart';
import 'package:intl/intl.dart';

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

    if (_token == null) {
      await _generateToken().then((value) {
        if (value) {
          _startTimer();
        } else {
          onTokenEror();
        }
      });
    } else {
      Endpoints.token = _token!;
      _startTimer();
    }
  }

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
        _token = value.token;
        _tokenExpirationDuration = value.tokenExpire;

        Endpoints.token = value.token.toString();
        _prefs!.setString(_TOKEN_KEY, token);
        _prefs!.setString(_TOKEN_EXPIRY_KEY, tokenExpire);
      }
    });
    return true;
  }
}
