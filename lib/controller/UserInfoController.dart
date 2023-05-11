import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Utils/Constants.dart';
import '../data/DataStore.dart';

class UserInfoController{
  static Future<List<String>> changePassword(String oldPassword,String newPassword) async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    String? token = userData.getString('token');
    List<String>result=["400","Request failed!"];

    var url=Uri.parse(changePasswordUri);
    if(token!=null){
      Map<String,dynamic> body = {
        'token':token,
        'oldPassword':oldPassword,
        'newPassword':newPassword
      };
      final response=await http.post(url,body: body);
      var map=json.decode(response.body);

      result[0]=response.statusCode.toString();
      result[1]=map['message'];

    }
    return result;
  }

  static Future<List<String>> updateProfile(String name,String email, String contact) async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    String? token = userData.getString('token');
    List<String>result=["400","Request failed!"];

    var url=Uri.parse(updateProfileUri);
    if(token!=null){
      Map<String,dynamic> body = {
        'token':token,
        'name':name,
        'email':email,
        'contact':contact
      };
      final response=await http.post(url,body: body);
      var map=json.decode(response.body);

      result[0]=response.statusCode.toString();
      result[1]=map['message'];

      if(response.statusCode==200){
        await DataStore.storeData(map);
      }

    }
    return result;
  }
}