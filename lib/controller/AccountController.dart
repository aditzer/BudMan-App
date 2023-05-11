import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Utils/Constants.dart';
import '../data/DataStore.dart';

class AccountController{

  static Future<List<String>> addAccount(String accountName,String accountNumber,String accountType,String accountBalance) async {

    final SharedPreferences userData = await SharedPreferences.getInstance();
    String? token = userData.getString('token');
    List<String>result=["400","Request failed!"];

    var url=Uri.parse(addAccountUri);
    if(token!=null){
      Map<String,dynamic> body = {
        'token':token,
        'accountName':accountName,
        'accountNumber':accountNumber,
        'accountType':accountType,
        'accountBalance':accountBalance
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

  static Future<List<String>> deleteAccount(String id) async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    String? token = userData.getString('token');
    List<String>result=["400","Request failed!"];

    var url=Uri.parse(removeAccountUri);
    if(token!=null){
      Map<String,dynamic> body = {
        'token':token,
        'accountId':id
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