import 'package:budman_app/controller/GoalController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/Buttons/CustomButton.dart';
import '../components/TextFields/CustomTransactionField.dart';
import '../components/Toasts/CustomUserMessage.dart';
import 'DashBoard.dart';
import 'SideNavBar.dart';

class AddGoals extends StatefulWidget {
  const AddGoals({Key? key}) : super(key: key);

  @override
  State<AddGoals> createState() => _AddGoalsState();
}

class _AddGoalsState extends State<AddGoals> {
  bool isLoading=false;
  TextEditingController goalNameController=TextEditingController();
  TextEditingController targetAmountController=TextEditingController();
  TextEditingController savedAmountController=TextEditingController();
  DateTime selectedDate=DateTime.now();

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
          title: Text("Add Goals"),
          backgroundColor: Colors.black,
        ),
        drawer: SideNavBar(),
        body:isLoading? const Center(child: CircularProgressIndicator()): ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "New Goal",
                style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  CustomTransactionField(
                    hintText: "Goal Name",
                    obscureText: false,
                    controller: goalNameController,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTransactionField(
                    hintText: "Target Amount",
                    obscureText: false,
                    controller: targetAmountController,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTransactionField(
                    hintText: "Saved Amount",
                    obscureText: false,
                    controller: savedAmountController,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () => selectDate(context),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: height * 0.065,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(3)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedDate.toString().substring(0,10)+"  (Target Date)",
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.calendar_today_rounded),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomButton(buttonText: "Submit",onTap: (){onClickSubmitNewGoal();}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  Future<void> onClickSubmitNewGoal() async {
    if(goalNameController.text.isEmpty){
      CustomUserMessage.sendMessage("Goal Name cannot be empty!");
      return;
    }
    else if(targetAmountController.text.isEmpty || !targetAmountController.text.isNumericOnly || savedAmountController.text.isEmpty || !savedAmountController.text.isNumericOnly){
      CustomUserMessage.sendMessage("Invalid Amount!");
      return;
    }
    else{
      setState(() {
        isLoading=true;
      });
      List<String>result=await GoalController.addGoal(goalNameController.text, targetAmountController.text, savedAmountController.text, selectedDate.toString().substring(0,10));
      setState(() {
        isLoading=false;
      });
      CustomUserMessage.sendMessage(result[1]);
      goalNameController.text="";
      targetAmountController.text="";
      savedAmountController.text="";
    }
  }
}
