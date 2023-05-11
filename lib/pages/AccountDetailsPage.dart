import 'package:budman_app/components/Cards/CustomAccountCard.dart';
import 'package:budman_app/controller/AccountController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/Alerts/CustomAlertDialog.dart';
import '../data/FetchData.dart';
import '../components/Toasts/CustomUserMessage.dart';
import '../models/Account.dart';
import '../models/User.dart';
import 'DashBoard.dart';
import 'SideNavBar.dart';

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({Key? key}) : super(key: key);

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  bool isLoading=false;
  User user = User("null", "null", "null", "null", "null", [],0,[],[]);
  Future<User> getData() async {
    user = await FetchData.fetchStoredData();
    return user;
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Account Details"),
        ),
        drawer: SideNavBar(),
        body: isLoading? const Center(child: CircularProgressIndicator()): FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if(snapshot.hasData){
              return Center(
                  child: buildAccount(user.accounts)
              );
            }
            else{
              return Center(child: CircularProgressIndicator());
            }
          }
        ),
      ),
    );
  }
  Widget buildAccount(List<Account> accountList) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: accountList.length,
      itemBuilder: (context, index) {
        Account account = accountList[index];
        return CustomAccountCard(
            accountId: account.accountId,
            accountName: account.accountName,
            accountNumber: account.accountNumber,
            accountType: account.accountType,
            accountBalance: account.accountBalance,
            onClickDelete: ()=>onClickDelete(account.accountId)
        );
      },
    );
  }
  Future<void> onClickDelete(String id) async {
    await CustomAlertDialog.customAlertButton(context, () => onClickDeleteYes(id), 'Do you want to delete?', 'Yes', 'No');
  }
  Future<void> onClickDeleteYes(String id) async {
    setState(() {
      isLoading=true;
    });
    List<String>result=await AccountController.deleteAccount(id);
    setState(() {
      isLoading=false;
    });
    await CustomUserMessage.sendMessage(result[1]);
    if(result[0]=='200'){
      Get.offAll(()=>AccountDetailsPage());
    }
  }
}
