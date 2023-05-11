import 'package:budman_app/Utils/Constants.dart';
import 'package:budman_app/data/ChartData.dart';

import '../models/User.dart';
import 'FetchData.dart';

class DeepAnalysisCalculation{
  late User user;

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  Future<List<ChartData>> calculateYearlyBarGraph() async {
    user= await FetchData.fetchStoredData();

    List<ChartData>data=[];
    for(int i=0;i<MONTHS.length;i++){
      data.add(ChartData(MONTHS[i], 0));
    }

    var dateNow=DateTime.now();
    var currYear=dateNow.year;
    for(int i=0;i<user.expenses.length;i++){
      String dateStr=user.expenses[i].date;
      var dateThen=DateTime.parse(dateStr);
      if(dateThen.year==currYear){
        data[dateThen.month-1].secondaryAxis+=user.expenses[i].amount;
      }
    }
    return data;
  }

  List<ChartData> calculateAllTimeCategoryExpense(){
    List<ChartData>data=[];
    for(int i=0;i<categories.length;i++){
      data.add(ChartData(categories[i]![1], 0));
    }
    var dateNow=DateTime.now();
    for(int i=0;i<user.expenses.length;i++){
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
      data[idx].secondaryAxis+=user.expenses[i].amount;
    }
    return data;
  }

  List<List<ChartDataNumeric>> calculateCompareExpenseGraph(){
    List<List<ChartDataNumeric>>data=[[],[],[]];
    var date0=DateTime(DateTime.now().year,DateTime.now().month,1);
    var date1=DateTime(date0.year,date0.month-1,1);
    var date2=DateTime(date0.year,date0.month-2,1);

    List<int>amount0=List<int>.filled(32, 0);
    List<int>amount1=List<int>.filled(32, 0);
    List<int>amount2=List<int>.filled(32, 0);

    for(int i=0;i<user.expenses.length;i++){
      String dateStr=user.expenses[i].date;
      var date=DateTime.parse(dateStr);
      if(date.year==date0.year && date.month==date0.month){
        amount0[date.day]+=user.expenses[i].amount;
      }
      else if(date.year==date1.year && date.month==date1.month){
        amount1[date.day]+=user.expenses[i].amount;
      }
      else if(date.year==date2.year && date.month==date2.month){
        amount2[date.day]+=user.expenses[i].amount;
      }
    }

    for(int i=1;i<32;i++) {
      data[0].add(ChartDataNumeric(i, amount0[i]));
      data[1].add(ChartDataNumeric(i, amount1[i]));
      data[2].add(ChartDataNumeric(i, amount2[i]));
    }
    return data;
  }
}