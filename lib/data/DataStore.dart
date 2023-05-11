import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DataStore{
  static Future<bool> storeData(var map) async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    bool result=await userData.setString("User", jsonEncode(map));
    await userData.setString("token", map['token']);
    return result;
  }

  static Future<String?> loadData() async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    String? userPref = userData.getString('User');
    return userPref;
  }

  static Future<void> deleteData() async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    userData.clear();
  }
}