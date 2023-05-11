import 'package:budman_app/data/FetchData.dart';

import '../models/User.dart';

class CalculateTransactionData{
  late User user;

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  Future<List<int>> calculateExpenses() async {
    user= await FetchData.fetchStoredData();
    List<int> result=[0,0,0,user.salary];
    var dateNow=DateTime.now();
    for(int i=0;i<user.expenses.length;i++){
      String dateStr=user.expenses[i].date;
      var dateThen=DateTime.parse(dateStr);
      if(dateNow.compareTo(dateThen)<0){
        continue;
      }
      var difference=dateNow.difference(dateThen).inDays;
      if(difference==0){
        result[0]+=user.expenses[i].amount;
        result[1]+=user.expenses[i].amount;
        result[2]+=user.expenses[i].amount;
      }
      else if(difference<7){
        result[1]+=user.expenses[i].amount;
        result[2]+=user.expenses[i].amount;
      }
      else if(difference<=30){
        result[2]+=user.expenses[i].amount;
      }
    }
    return result;
  }

  List<double> calculateBarGraph(){
    List<double>result=[0,0,0,0,0,0,0];
    var dateNow=DateTime.now();
    for(int i=0;i<user.expenses.length;i++){
      String dateStr=user.expenses[i].date;
      var dateThen=DateTime.parse(dateStr);
      if(dateNow.compareTo(dateThen)<0){
        continue;
      }
      int difference=dateNow.difference(dateThen).inDays;
      if(difference>6) {
        continue;
      } else{
        result[difference]+=user.expenses[i].amount;
      }
    }
    return result;
  }

  List<int> calculatePieChart(){
    List<int>result=[0,0,0,0,0];
    var dateNow=DateTime.now();
    var monthNow=dateNow.month;
    var yearNow=dateNow.year;
    for(int i=0;i<user.expenses.length;i++){
      String dateStr=user.expenses[i].date;
      var dateThen=DateTime.parse(dateStr);
      if(dateNow.compareTo(dateThen)<0){
        continue;
      }
      if(yearNow!=dateThen.year || monthNow!=dateThen.month){
        continue;
      }
      String str=user.expenses[i].category;
      int idx=0;
      if(str=="Bills") {
        idx=0;
      } else if(str=="Food") {
        idx=1;
      } else if(str=="Medical") {
        idx=2;
      } else if(str=="Travel") {
        idx=3;
      } else if(str=="Others") {
        idx=4;
      }
      result[idx]+=user.expenses[i].amount;
    }
    return result;
  }

}