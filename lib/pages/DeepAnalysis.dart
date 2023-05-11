import 'package:budman_app/components/Charts/MultiLineChart.dart';
import 'package:budman_app/data/DeepAnalysisCalculation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/Charts/HorizontalBarChart.dart';
import '../data/ChartData.dart';
import 'DashBoard.dart';
import 'SideNavBar.dart';

class DeepAnalysis extends StatefulWidget {
  const DeepAnalysis({Key? key}) : super(key: key);

  @override
  State<DeepAnalysis> createState() => _DeepAnalysisState();
}

class _DeepAnalysisState extends State<DeepAnalysis> {
  DeepAnalysisCalculation deepAnalysisCalculation=DeepAnalysisCalculation();
  List<ChartData> yearlyBarGraphData = [];
  List<ChartData> allTimeCategoryExpenseData=[];
  List<List<ChartDataNumeric>> compareExpenseData=[];

  Future<List<ChartData>> getData() async {
    yearlyBarGraphData=await deepAnalysisCalculation.calculateYearlyBarGraph();
    allTimeCategoryExpenseData=deepAnalysisCalculation.calculateAllTimeCategoryExpense();
    compareExpenseData=deepAnalysisCalculation.calculateCompareExpenseGraph();
    return yearlyBarGraphData;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop:() async{
        Get.offAll(()=>DashBoardPage());
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Deep Analysis"),
        ),
        drawer: SideNavBar(),
        body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<List<ChartData>> snapshot) {
            if(snapshot.hasData){
              return ListView(
                children: [
                  SizedBox(height: height*0.05,),
                  HorizontalBarChart(chartData: yearlyBarGraphData,label: "Month-wise Expenses",isSmall: false,),
                  SizedBox(height: height*0.1,),
                  HorizontalBarChart(chartData: allTimeCategoryExpenseData,label: "Category-wise Expenses (All Time)",isSmall: true,),
                  SizedBox(height: height*0.1,),
                  MultiLineChart(data: compareExpenseData),
                  SizedBox(height: 20,),
                ],
              );
            }
            else{
              return const Center(child: CircularProgressIndicator());
            }
          }
        ),
      ),
    );
  }
}
