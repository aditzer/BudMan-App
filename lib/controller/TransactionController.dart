import 'dart:convert';

import 'package:budman_app/Utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../data/DataStore.dart';

class TransactionController{

  static Future<List<String>> addTransaction(String name,String amount,String category,String description,String date) async {

    final SharedPreferences userData = await SharedPreferences.getInstance();
    String? token = userData.getString('token');
    List<String>result=["400","Request failed!"];

    var url=Uri.parse(addExpenseUri);
    if(token!=null){
      Map<String,dynamic> body = {
        'token':token,
        'name':name,
        'amount':amount,
        'category':category,
        'description':description,
        'date':date
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

  static Future<List<String>> addCredit(String salary) async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    String? token = userData.getString('token');
    List<String>result=["400","Request failed!"];

    var url=Uri.parse(addCreditUri);
    if(token!=null){
      Map<String,dynamic> body = {
        'token':token,
        'salary':salary
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

  static Future<List<String>> deleteExpense(String id) async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    String? token = userData.getString('token');
    List<String>result=["400","Request failed!"];

    var url=Uri.parse(removeExpenseUri);
    if(token!=null){
      Map<String,dynamic> body = {
        'token':token,
        'id':id
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

  static Future<List<String>> editTransaction(String id,String name,String amount,String category,String description,String date) async {

    final SharedPreferences userData = await SharedPreferences.getInstance();
    String? token = userData.getString('token');
    List<String>result=["400","Request failed!"];

    var url=Uri.parse(editExpenseUri);
    if(token!=null){
      Map<String,String> body = {
        'token':token,
        'expenseId':id,
        'name':name,
        'amount':amount,
        'category':category,
        'description':description,
        'date':date
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