import 'package:budman_app/Utils/Constants.dart';
import 'package:budman_app/components/Buttons/CustomButton.dart';
import 'package:budman_app/components/TextFields/CustomTransactionField.dart';
import 'package:budman_app/pages/DashBoard.dart';
import 'package:budman_app/pages/SideNavBar.dart';
import 'package:budman_app/pages/TransactionHistory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/TransactionController.dart';
import '../components/Toasts/CustomUserMessage.dart';

class AddTransaction extends StatefulWidget {
  String expenseId;
  String initialItemName;
  String initialDescription;
  String initialAmount;
  String selectedCategory;
  DateTime selectedDate;
  bool newMode;
  AddTransaction({Key? key,required this.expenseId,required this.initialItemName,required this.newMode,required this.initialDescription,required this.initialAmount,required this.selectedDate,required this.selectedCategory}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  late TextEditingController itemName;
  late TextEditingController description;
  late TextEditingController amount;
  bool isLoading=false;

  TextEditingController creditController = TextEditingController();
  Future<void> onClickCredit(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 30,
            title: const Text('Add Credit'),
            content: TextField(
              controller: creditController,
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
                onPressed: () {
                  onClickCreditOk();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    itemName=TextEditingController(text:widget.initialItemName);
    description=TextEditingController(text: widget.initialDescription);
    amount=TextEditingController(text: widget.initialAmount);
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
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Add Transaction"),
        ),
        drawer: SideNavBar(),
        body:isLoading? const Center(child: CircularProgressIndicator()): ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "New Transaction",
                style: GoogleFonts.publicSans(
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
                    hintText: "Item Name",
                    obscureText: false,
                    controller: itemName,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white70, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white70, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                      ),
                      value: widget.selectedCategory,
                      items: dropdownItems,
                      onChanged: (String? value) {
                        widget.selectedCategory = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTransactionField(
                      hintText: "Description", obscureText: false,controller: description,),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
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
                            widget.selectedDate.toString().substring(0,10),
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
                  CustomTransactionField(hintText: "Amount", obscureText: false,controller: amount,),
                  const SizedBox(
                    height: 35,
                  ),
                  CustomButton(buttonText: "Submit",onTap: (){
                    onClickSubmit();
                  },),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            widget.newMode==true ? Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: CustomButton(
                  buttonText: "+  Add Credit",
                  onTap:()=>onClickCredit(context),
                ),
            ):SizedBox(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onClickCreditOk() async {
    if(creditController.text.isEmpty){
      await CustomUserMessage.sendMessage("Amount cannot be empty!");
    }
    else{
      setState(() {
        isLoading=true;
      });
      List<String>result=await TransactionController.addCredit(creditController.text);
      setState(() {
        isLoading=false;
      });
      await CustomUserMessage.sendMessage(result[1]);
    }
  }

  Future<void> onClickSubmit() async {
    if(itemName.text.isEmpty){
      await CustomUserMessage.sendMessage("Item name cannot be empty!");
      return;
    }
    else if(amount.text.isEmpty){
      await CustomUserMessage.sendMessage("Amount cannot be empty!");
      return;
    }
    else if(!amount.text.isNumericOnly){
      await CustomUserMessage.sendMessage("Enter valid amount!");
      return;
    }
    else{
      List<String>result;
      setState(() {
        isLoading=true;
      });
      if(widget.newMode) {
        result=await TransactionController.addTransaction(itemName.text,amount.text,widget.selectedCategory,description.text,widget.selectedDate.toString().substring(0,10));
        setState(() {
          isLoading=false;
        });
      } else {
        result=await TransactionController.editTransaction(widget.expenseId,itemName.text,amount.text,widget.selectedCategory,description.text,widget.selectedDate.toString().substring(0,10));
        setState(() {
          isLoading=false;
        });
        await CustomUserMessage.sendMessage(result[1]);
        Get.offAll(()=>TransactionHistory());
      }
      await CustomUserMessage.sendMessage(result[1]);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != widget.selectedDate) {
      setState(() {
        widget.selectedDate = picked;
      });
    }
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          value: categories[0]![1], child: Text(categories[0]![0])),
      DropdownMenuItem(
          value: categories[1]![1], child: Text(categories[1]![0])),
      DropdownMenuItem(
          value: categories[2]![1], child: Text(categories[2]![0])),
      DropdownMenuItem(
          value: categories[3]![1], child: Text(categories[3]![0])),
      DropdownMenuItem(
          value: categories[4]![1], child: Text(categories[4]![0])),
    ];
    return menuItems;
  }
}
