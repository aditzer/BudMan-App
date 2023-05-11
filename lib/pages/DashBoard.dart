import 'package:budman_app/Utils/Constants.dart';
import 'package:budman_app/components/Charts/BarGraph.dart';
import 'package:budman_app/components/Cards/CustomCard.dart';
import 'package:budman_app/data/CalculateTransactionData.dart';
import 'package:budman_app/pages/SideNavBar.dart';
import 'package:flutter/material.dart';

import '../components/Charts/PieChartTransaction.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  List<int> result = [];
  List<double> dataList=[];
  List<int> pieChartData=[];
  int highest=0;

  Future<List<int>> getData() async {
    CalculateTransactionData calculateTransactionData=CalculateTransactionData();
    result = await calculateTransactionData.calculateExpenses();
    dataList=calculateTransactionData.calculateBarGraph();
    pieChartData=calculateTransactionData.calculatePieChart();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("DashBoard"),
        ),
        drawer: SideNavBar(),
        body: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, left: 10),
                          child: Row(
                            children: [
                              CustomCard(
                                color: colorCardGreen,
                                money: result[0],
                                icon: Icons.calendar_today,
                                backgroundShadeColor: colorCardGreenDark,
                                title: "Today's Expense",
                              ),
                              CustomCard(
                                color: colorCardBlue,
                                money: result[1],
                                icon: Icons.calendar_view_week,
                                backgroundShadeColor: colorCardBlueDark,
                                title: "Weekly Expenses",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, left: 10),
                          child: Row(
                            children: [
                              CustomCard(
                                color: colorCardPurple,
                                money: result[2],
                                icon: Icons.calendar_month,
                                backgroundShadeColor: colorCardPurpleDark,
                                title: "Monthly Expenses",
                              ),
                              CustomCard(
                                color: colorCardRed,
                                money: result[3],
                                icon: Icons.currency_rupee,
                                backgroundShadeColor: colorCardRedDark,
                                title: "Credit",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        BarGraph(dataList: dataList),
                        SizedBox(height: 30,),
                        PieChartTransaction(data: pieChartData,),
                        SizedBox(height: 30,),
                      ],
                    )
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

}
