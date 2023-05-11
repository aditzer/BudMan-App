import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/ChartData.dart';

class HorizontalBarChart extends StatefulWidget {
  List<ChartData> chartData = [];
  String label;
  bool isSmall;
  HorizontalBarChart({Key? key,required this.chartData,required this.label,required this.isSmall}) : super(key: key);

  @override
  State<HorizontalBarChart> createState() => _HorizontalBarChartState();
}

class _HorizontalBarChartState extends State<HorizontalBarChart> {
  int highest=0;
  @override
  void initState() {
    super.initState();
    for(int i=0;i<widget.chartData.length;i++){
      highest=max(highest,widget.chartData[i].secondaryAxis);
    }
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(
              5.0,
              5.0,
            ), //Offset
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
        color: Colors.white,
        border: Border.all(
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children:[
          SizedBox(height: 10),
          Text(widget.label,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          SizedBox(height: height*0.05,),
          SizedBox(
          height: widget.isSmall? height*0.2: height*0.4,
          width: width,
          child: SfCartesianChart(
              series: <ChartSeries>[
                BarSeries<ChartData, String>(
                    color: Colors.blue,
                    width: 0.5,
                    dataSource: widget.chartData,
                    xValueMapper: (ChartData data, _) => data.primaryAxis,
                    yValueMapper: (ChartData data, _) => data.secondaryAxis,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                )
              ],
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.none,
              minimum: 0,
              maximum: highest.toDouble(),
              interval: highest/4
            ),
          ),
        ),
      ]
      ),
    );
  }
}

