import 'package:budman_app/Utils/Constants.dart';
import 'package:budman_app/controller/AccountController.dart';
import 'package:budman_app/components/Toasts/CustomUserMessage.dart';
import 'package:budman_app/pages/SideNavBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/Buttons/CustomButton.dart';
import '../components/TextFields/CustomTransactionField.dart';
import 'DashBoard.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({Key? key}) : super(key: key);

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  bool isLoading=false;
  String selectedAccountType="Cash";
  TextEditingController accountNameController=TextEditingController();
  TextEditingController accountNumberController=TextEditingController();
  TextEditingController accountBalanceController=TextEditingController();

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
          title: Text("Add Account"),
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
                "New Account",
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
                    hintText: "Account Name",
                    obscureText: false,
                    controller: accountNameController,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTransactionField(
                    hintText: "Account Number",
                    obscureText: false,
                    controller: accountNumberController,
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
                      value: selectedAccountType,
                      items: dropdownItems,
                      onChanged: (String? value) {
                        selectedAccountType = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTransactionField(
                    hintText: "Account Balance",
                    obscureText: false,
                    controller: accountBalanceController,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  CustomButton(buttonText: "Submit",onTap: (){onClickSubmitNewAccount();}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> onClickSubmitNewAccount() async {
    if(accountNameController.text.isEmpty){
      CustomUserMessage.sendMessage("Account Name cannot be empty!");
      return;
    }
    else if(accountNumberController.text.isEmpty || !accountNumberController.text.isNumericOnly){
      CustomUserMessage.sendMessage("Invalid Account Number!");
      return;
    }
    else if(accountBalanceController.text.isEmpty || !accountBalanceController.text.isNumericOnly){
      CustomUserMessage.sendMessage("Invalid Account Balance!");
      return;
    }
    else{
      setState(() {
        isLoading=true;
      });
      List<String>result=await AccountController.addAccount(accountNameController.text, accountNumberController.text, selectedAccountType, accountBalanceController.text);
      setState(() {
        isLoading=false;
      });
      CustomUserMessage.sendMessage(result[1]);
      accountNameController.text="";
      accountNumberController.text="";
      accountBalanceController.text="";
    }
  }
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(value: accountTypes[0], child: Text(accountTypes[0]!)),
      DropdownMenuItem(value: accountTypes[1], child: Text(accountTypes[1]!)),
      DropdownMenuItem(value: accountTypes[2], child: Text(accountTypes[2]!)),
      DropdownMenuItem(value: accountTypes[3], child: Text(accountTypes[3]!)),
      DropdownMenuItem(value: accountTypes[4], child: Text(accountTypes[4]!))
    ];
    return menuItems;
  }
}
