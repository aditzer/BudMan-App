import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/ChartData.dart';

class MultiLineChart extends StatefulWidget {
  List<List<ChartDataNumeric>> data;
  MultiLineChart({Key? key, required this.data}) : super(key: key);

  @override
  State<MultiLineChart> createState() => _MultiLineChartState();
}

class _MultiLineChartState extends State<MultiLineChart> {
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
        children: [
          SizedBox(height: 10),
          Text("Compare Expenses",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          SizedBox(height: height*0.05,),
          SizedBox(
            height: height * 0.4,
            width: 500,
            child: SfCartesianChart(series: <CartesianSeries<ChartDataNumeric, num>>[
            LineSeries<ChartDataNumeric, num>(
              dataSource: widget.data[0],
              xValueMapper: (ChartDataNumeric data, _) => data.xAxis,
              yValueMapper: (ChartDataNumeric data, _) => data.yAxis,
              name: 'Current Month',
              color: Colors.green,
              width: 3
            ),
            LineSeries<ChartDataNumeric, num>(
              dataSource: widget.data[1],
              xValueMapper: (ChartDataNumeric data, _) => data.xAxis,
              yValueMapper: (ChartDataNumeric data, _) => data.yAxis,
              name: 'Previous Month',
              color: Colors.blue, width: 3
            ),
            LineSeries<ChartDataNumeric, num>(
              dataSource: widget.data[2],
              xValueMapper: (ChartDataNumeric data, _) => data.xAxis,
              yValueMapper: (ChartDataNumeric data, _) => data.yAxis,
              name: 'Pre-Previous Month',
              color: Colors.orange, width: 3
            ),
                ]),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: width*0.015,
                    ),
                    SizedBox(
                      width: width*0.01,
                    ),
                    Text(
                      "Current Month",
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width*0.02),
                child: Row(
                  children: [
                     CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: width*0.015,
                    ),
                    SizedBox(
                      width: width*0.01,
                    ),
                    Text(
                      "Previous Month",
                      style:TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width*0.02),
                child: Row(
                  children: [
                     CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: width*0.015,
                    ),
                    SizedBox(
                      width: width*0.01,
                    ),
                    Text(
                      "Pre-Previous Month",
                      style:TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
