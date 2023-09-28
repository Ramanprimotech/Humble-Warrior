import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceData {

  static clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
  static removeField(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }

  static addStringToSF(String key ,String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key , value);
  }

  static getStringValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(key);
    return stringValue;
  }


  static addBoolToSF(String key ,bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key , value);
  }
  static getBoolValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    bool? boolValue = prefs.getBool(key);
    return boolValue;
  }



}
