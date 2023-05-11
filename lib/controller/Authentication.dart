import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/Constants.dart';
import '../data/DataStore.dart';

class Authentication{
  static Future<List<String>> login(String email,String password) async {
    var map;
    var loginUrl=Uri.parse(loginUri);
    List<String> result=[];
    Map<String,String> body = {
      'email': email,
      'password': password
    };
    final response=await http.post(loginUrl,body: body);
    map=json.decode(response.body);
    result.add(response.statusCode.toString());
    result.add(map['message']);
    if(response.statusCode==200){
      bool res=await DataStore.storeData(map);
      if(!res){
        result[0]="400";
        result[1]="An Error occurred!";
      }
    }
    return result;
  }
  static Future<List<String>> register(String name,String email,String password,String contact) async {
    var map;
    var loginUrl=Uri.parse(registerUri);
    List<String> result=[];
    Map<String,String> body = {
      'email': email,
      'password': password,
      'name':name,
      'contact':contact
    };
    final response=await http.post(loginUrl,body: body);
    map=json.decode(response.body);
    result.add(response.statusCode.toString());
    result.add(map['message']);
    if(response.statusCode==200){
      bool res=await DataStore.storeData(map);
      if(!res){
        result[0]="400";
        result[1]="An Error occurred!";
      }
    }
    return result;
  }
  static Future<void> refreshUser() async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    String? token = userData.getString('token');
    var getUserUrl=Uri.parse(getUserUri);
    if(token!=null){
      Map<String,String> body = {
        'token':token
      };
      final response=await http.post(getUserUrl,body: body);
      var map=json.decode(response.body);
      if(response.statusCode==200){
        await DataStore.storeData(map);
      }
    }
  }
}