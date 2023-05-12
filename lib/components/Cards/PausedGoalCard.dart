import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PausedGoalCard extends StatelessWidget {
  String goalName;
  String targetAmount;
  String savedAmount;
  String desiredDate;
  final Function()? onClickStart;
  final Function()? onClickDelete;
  final Function()? onClickComplete;
  PausedGoalCard({Key? key,required this.targetAmount,required this.goalName,required this.savedAmount,required this.desiredDate,required this.onClickStart, required this.onClickDelete,required this.onClickComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Card(
      margin: const EdgeInsets.only(left: 30,right: 30,top: 20),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40.0))),
      color: Colors.orange[200],
      elevation: 9,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          gradient: LinearGradient(
            colors: [Color(0xfffab57d),Colors.white],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 12,
              offset: Offset(0, 6),
            )
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 5,),
            Padding(
              padding: EdgeInsets.only(left:width*0.1,top:10,right: width*0.1),
              child: Row(
                children: [
                  Expanded(child:Text(goalName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:width*0.1,top:10,right: width*0.1),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: Text("Desired Date: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)
                    ),
                    Expanded(
                        child: Text(desiredDate,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.orange),)
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            CircularPercentIndicator(
              radius: width*0.2,
              lineWidth: 10,
              percent: (int.parse(savedAmount)>=int.parse(targetAmount))?1:((int.parse(savedAmount)/int.parse(targetAmount))),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.white,
              progressColor: Colors.orange,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Tooltip(
                      message: (int.parse(savedAmount) >= int.parse(targetAmount))?"Remaining amount: 0":"Remaining amount: "+(int.parse(targetAmount)-int.parse(savedAmount)).toString(),
                      child: Text((int.parse(savedAmount)>=int.parse(targetAmount))?"100%":((int.parse(savedAmount)/int.parse(targetAmount))*100).toInt().toString()+"%",style: TextStyle(fontSize: 30),)),
                  Text(savedAmount+"/"+targetAmount,style: TextStyle(fontSize: 12),)
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Tooltip(
                    message: "Activate Goal",
                    child: IconButton(
                      icon: const Icon(
                        Icons.play_circle_fill,
                        size: 30,
                        color: Colors.blue,
                      ),
                      onPressed: () async {
                        await onClickStart!();
                      },
                    ),
                  ),
                  SizedBox(width: 10,),
                  Tooltip(
                    message: "Complete Goal",
                    child: IconButton(
                      icon: const Icon(
                        Icons.check,
                        size: 30,
                        color: Colors.green,
                      ),
                      onPressed: () async {
                        await onClickComplete!();
                      },
                    ),
                  ),
                  SizedBox(width: 10,),
                  Tooltip(
                    message: "Delete",
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        await onClickDelete!();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
