import 'package:budman_app/Utils/Constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PieChartTransaction extends StatefulWidget {
  List<int> data;
  PieChartTransaction({Key? key, required this.data}) : super(key: key);

  @override
  State<PieChartTransaction> createState() => _PieChartTransactionState();
}

class _PieChartTransactionState extends State<PieChartTransaction> {
  @override
  Widget build(BuildContext context) {
    calculatePieData();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
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
          Text(
            "Pie Chart (This month)",
            style: GoogleFonts.publicSans(
                fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height * 0.4,
            width: width * 0.9,
            child: PieChart(PieChartData(
                sections: pieData,
                sectionsSpace: 0,
                centerSpaceRadius: width * 0.2)),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 7,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Bills",
                      style: GoogleFonts.publicSans(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 7,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Food",
                      style: GoogleFonts.publicSans(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 7,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Medical",
                      style: GoogleFonts.publicSans(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.purple,
                      radius: 7,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Travel",
                      style: GoogleFonts.publicSans(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.yellow,
                      radius: 7,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Others",
                      style: GoogleFonts.publicSans(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  List<PieChartSectionData> pieData = [];
  void calculatePieData() {
    pieData = [];
    int total = 0;

    for (int i = 0; i < widget.data.length; i++) {
      total += widget.data[i];
    }
    for (int i = 0; i < widget.data.length; i++) {
      if (widget.data[i] == 0) {
        continue;
      } else {
        double percentage = (widget.data[i] / total) * 100;
        pieData.add(PieChartSectionData(
            value: (widget.data[i] / total)*360,
            titlePositionPercentageOffset: 1.5,
            title: "${percentage.toInt()}%",
            titleStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
            color: categoriesByColor[i]));
      }
    }
  }
}
