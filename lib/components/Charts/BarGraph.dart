import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BarGraph extends StatefulWidget {
  List<double> dataList=[];
  BarGraph({Key? key,required this.dataList}) : super(key: key);

  @override
  State<BarGraph> createState() => _BarGraphState();
}

class _BarGraphState extends State<BarGraph> {
  int highest=10;
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
          Text("Bar Graph",style: GoogleFonts.publicSans(fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: height*0.05,),
          SizedBox(
            height: height * 0.35,
            width: width * 0.9,
            child: BarChart(
              BarChartData(
                backgroundColor: Colors.white10,
                barGroups: _chartGroups(),
                borderData: FlBorderData(
                    border: const Border(
                        bottom: BorderSide(),
                        left: BorderSide())),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles:
                  AxisTitles(sideTitles: _bottomTitles),
                  leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: highest/5,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      )),
                  topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  List<String>days=[];
  List<BarChartGroupData> _chartGroups() {
    List<BarChartGroupData> list = [];
    var dateNow=DateTime.now();
    List<String>month=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    for (int i = 0; i < widget.dataList.length; i++) {
      var newDate=dateNow.subtract(Duration(days:i));
      String d=newDate.day.toString();
      int m=newDate.month;
      days.add("$d-${month[m-1]}");
      highest=max(highest,widget.dataList[i].toInt());
      list.add(BarChartGroupData(
          x: i,
          barRods: [BarChartRodData(toY: widget.dataList[i], color: Colors.deepOrange)])
      );
    }
    return list;
  }
  SideTitles get _bottomTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      String text = days[value.toInt()];
      return Text(
        text,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      );
    },
  );
}
