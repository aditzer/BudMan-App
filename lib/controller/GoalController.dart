import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Utils/Constants.dart';
import '../data/DataStore.dart';

class GoalController{
  static Future<List<String>> addGoal(String goalName,String targetAmount,String savedAmount,String desiredDate) async {

    final SharedPreferences userData = await SharedPreferences.getInstance();
    String? token = userData.getString('token');
    List<String>result=["400","Request failed!"];

    var url=Uri.parse(addGoalUri);
    if(token!=null){
      Map<String,dynamic> body = {
        'token':token,
        'goalName':goalName,
        'targetAmount':targetAmount,
        'savedAmount':savedAmount,
        'desiredDate':desiredDate
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

  static Future<List<String>> addCredit(String amount,String id) async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    String? token = userData.getString('token');
    List<String>result=["400","Request failed!"];

    var url=Uri.parse(addGoalAmountUri);
    if(token!=null){
      Map<String,dynamic> body = {
        'token':token,
        'amount':amount,
        'goalId':id
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

  static Future<List<String>> changeGoalStatus(String status,String id) async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    String? token = userData.getString('token');
    List<String>result=["400","Request failed!"];

    var url=Uri.parse(changeGoalStatusUri);
    if(token!=null){
      Map<String,dynamic> body = {
        'token':token,
        'status':status,
        'goalId':id
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