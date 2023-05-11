import 'package:budman_app/components/Alerts/CustomAlertDialog.dart';
import 'package:budman_app/components/Cards/ActiveGoalCard.dart';
import 'package:budman_app/components/Toasts/CustomUserMessage.dart';
import 'package:budman_app/controller/GoalController.dart';
import 'package:budman_app/data/FetchGoalData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/Cards/CompletedGoalCard.dart';
import '../components/Cards/PausedGoalCard.dart';
import '../models/Goal.dart';
import 'DashBoard.dart';
import 'SideNavBar.dart';

class MyGoals extends StatefulWidget {
  const MyGoals({Key? key}) : super(key: key);
  @override
  State<MyGoals> createState() => _MyGoalsState();
}
class _MyGoalsState extends State<MyGoals> {
  bool isLoading=false;
  List<List<Goal>> data=[];
  TextEditingController amountController=TextEditingController();
  Future<List<List<Goal>>> getData() async {
    data=await FetchGoalData.goalData();
    return data;
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
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text("My Goals"),
            ),
            drawer: SideNavBar(),
            body: isLoading? const Center(child: CircularProgressIndicator()):FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<List<List<Goal>>> snapshot) {
              if(snapshot.hasData){
                return Column(
                  children: [
                    TabBar(
                      labelColor: Colors.black,
                      tabs: [
                        Tab(text: "Active",),
                        Tab(text: "Paused",),
                        Tab(text: "Completed",),
                      ],
                    ),
                    Expanded(
                    child: TabBarView(
                      children: [
                        buildActiveList(data[0]),
                        buildPausedList(data[1]),
                        buildCompletedList(data[2]),
                      ],
                    )
                    )
                  ],
                );
              }
              else{
                return Center(child: CircularProgressIndicator());
              }
            }
            ),
          ),
      ),
    );
  }

  Widget buildActiveList(List<Goal> activeGoalList){
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: activeGoalList.length,
      itemBuilder: (context, index) {
        Goal goal = activeGoalList[index];
        return ActiveGoalCard(
          goalName: goal.goalName,
          targetAmount: goal.targetAmount,
          savedAmount: goal.savedAmount,
          desiredDate: goal.desiredDate,
          onClickPause: ()=>CustomAlertDialog.customAlertButton(context, () => onClickPause(goal.id), "Are you sure you want to set Status to Paused?", "Yes", "No"),
          onClickComplete: ()=>CustomAlertDialog.customAlertButton(context, () => onClickComplete(goal.id), "Are you sure you want to set Status to Complete?", "Yes", "No"),
          onClickAddAmount: ()=>onClickAddAmount(goal.id,context),
          onClickDelete: ()=>CustomAlertDialog.customAlertButton(context, () => onClickDelete(goal.id), "Are you sure you want to delete?", "Yes", "No"),
        );
      },
    );
  }
  Widget buildPausedList(List<Goal> pausedGoalList){
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: pausedGoalList.length,
      itemBuilder: (context, index) {
        Goal goal = pausedGoalList[index];
        return PausedGoalCard(
          goalName: goal.goalName,
          targetAmount: goal.targetAmount,
          savedAmount: goal.savedAmount,
          desiredDate: goal.desiredDate,
          onClickStart: ()=>CustomAlertDialog.customAlertButton(context, () => onClickStart(goal.id), "Are you sure you want to set Status to Active?", "Yes", "No"),
          onClickComplete: ()=>CustomAlertDialog.customAlertButton(context, () => onClickComplete(goal.id), "Are you sure you want to set Status to Complete?", "Yes", "No"),
          onClickDelete: ()=>CustomAlertDialog.customAlertButton(context, () => onClickDelete(goal.id), "Are you sure you want to delete?", "Yes", "No"),
        );
      },
    );
  }
  Widget buildCompletedList(List<Goal> completedGoalList){
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: completedGoalList.length,
      itemBuilder: (context, index) {
        Goal goal = completedGoalList[index];
        return CompletedGoalCard(
          goalName: goal.goalName,
          targetAmount: goal.targetAmount,
          savedAmount: goal.savedAmount,
          desiredDate: goal.desiredDate,
          onClickDelete: ()=>CustomAlertDialog.customAlertButton(context, () => onClickDelete(goal.id), "Are you sure you want to delete?", "Yes", "No"),
        );
      },
    );
  }

  Future<void>onClickAddAmount(String goalId,BuildContext context) async{
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 30,
            title: const Text('Add Amount'),
            content: TextField(
              controller: amountController,
              decoration:
              const InputDecoration(hintText: "Enter Amount"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  if(amountController.text.isEmpty || !amountController.text.isNumericOnly){
                    CustomUserMessage.sendMessage("Invalid Amount!");
                    Navigator.pop(context);
                    return;
                  }
                  setState(() {
                    isLoading=true;
                  });
                  List<String> result=await GoalController.addCredit(amountController.text, goalId);
                  setState(() {
                    isLoading=false;
                  });
                  CustomUserMessage.sendMessage(result[1]);
                  Get.offAll(()=>MyGoals());
                },
              ),
            ],
          );
        },
    );
  }
  Future<void> onClickPause(String goalId) async {
    setState(() {
      isLoading=true;
    });
    List<String> result=await GoalController.changeGoalStatus("pause",goalId);
    setState(() {
      isLoading=false;
    });
    CustomUserMessage.sendMessage(result[1]);
    Get.offAll(()=>MyGoals());
  }
  Future<void> onClickComplete(String goalId) async {
    setState(() {
      isLoading=true;
    });
    List<String> result=await GoalController.changeGoalStatus("complete",goalId);
    setState(() {
      isLoading=false;
    });
    CustomUserMessage.sendMessage(result[1]);
    Get.offAll(()=>MyGoals());
  }
  Future<void> onClickDelete(String goalId) async {
    setState(() {
      isLoading=true;
    });
    List<String> result=await GoalController.changeGoalStatus("delete",goalId);
    setState(() {
      isLoading=false;
    });
    CustomUserMessage.sendMessage(result[1]);
    Get.offAll(()=>MyGoals());
  }
  Future<void> onClickStart(String goalId) async {
    setState(() {
      isLoading=true;
    });
    List<String> result=await GoalController.changeGoalStatus("active",goalId);
    setState(() {
      isLoading=false;
    });
    CustomUserMessage.sendMessage(result[1]);
    Get.offAll(()=>MyGoals());
  }

}


