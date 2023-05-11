import 'dart:convert';

import 'package:budman_app/models/Account.dart';
import 'package:budman_app/models/Expenses.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Goal.dart';
import '../models/User.dart';

class FetchData{
  static Future<User> fetchStoredData() async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    String? data = userData.getString('User');
    print(data);
    Map<String, dynamic> userMap = json.decode(data!);
    String name="",email="",token="",mobile="";
    int salary=0;
    List<Expenses>expenses=[];
    List<Account> accounts=[];
    List<Goal> goals=[];

    name=userMap['user']['name'];
    email=userMap['user']['email'];
    mobile=userMap['user']['contact'];
    token=userMap['token'];
    salary=userMap['user']['salary'];
    for(int i=0;i<userMap['user']['expenses'].length;i++){
      String expId=userMap['user']['expenses'][i]['_id'];
      String expName=userMap['user']['expenses'][i]['name'];
      int expAmount=userMap['user']['expenses'][i]['amount'];
      String expCategory=userMap['user']['expenses'][i]['category'];
      String expDescription=userMap['user']['expenses'][i]['description'];
      String expDate=userMap['user']['expenses'][i]['date'];
      Expenses exp= Expenses(expId, expName, expAmount, expCategory, expDescription, expDate);
      expenses.add(exp);
    }
    for(int i=0;i<userMap['user']['accounts'].length;i++){
      String accountName=userMap['user']['accounts'][i]['accountName'];
      String accountNumber=userMap['user']['accounts'][i]['accountNumber'].toString();
      String accountType=userMap['user']['accounts'][i]['accountType'];
      String accountBalance=userMap['user']['accounts'][i]['accountBalance'].toString();
      String accountId=userMap['user']['accounts'][i]['_id'];
      Account account=Account(accountId, accountName, accountNumber, accountType, accountBalance);
      accounts.add(account);
    }
    for(int i=0;i<userMap['user']['goals'].length;i++){
      String goalName=userMap['user']['goals'][i]['goalName'];
      String goalStatus=userMap['user']['goals'][i]['goalStatus'];
      String targetAmount=userMap['user']['goals'][i]['targetAmount'].toString();
      String savedAmount=userMap['user']['goals'][i]['savedAmount'].toString();
      String desiredDate=userMap['user']['goals'][i]['desiredDate'];
      String id=userMap['user']['goals'][i]['_id'];
      Goal goal=Goal(goalName, goalStatus, targetAmount, savedAmount, desiredDate, id);
      goals.add(goal);
    }
    User user= User(name,email,"",mobile,token,expenses,salary,accounts,goals);
    return user;
  }
}