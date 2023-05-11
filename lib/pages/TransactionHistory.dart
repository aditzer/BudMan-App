import 'package:budman_app/components/Cards/CustomTransactionCard.dart';
import 'package:budman_app/models/Expenses.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/Alerts/CustomAlertDialog.dart';
import '../components/Toasts/CustomUserMessage.dart';
import '../controller/TransactionController.dart';
import '../data/FetchData.dart';
import '../models/User.dart';
import 'AddTransaction.dart';
import 'DashBoard.dart';
import 'SideNavBar.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
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
          title: const Text("Transaction History"),
        ),
        drawer: SideNavBar(),
        body: isLoading? const Center(child: CircularProgressIndicator()): FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: buildTransactions(user.expenses),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Widget buildTransactions(List<Expenses> transactionList) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20),
        itemCount: transactionList.length,
        itemBuilder: (context, index) {
          Expenses transaction = transactionList[index];
          return CustomTransactionCard(
            name: transaction.name,
            amount: transaction.amount,
            category: transaction.category,
            description: transaction.description,
            date: transaction.date,
            id:transaction.id,
            onClickEdit: ()=>onClickEdit(transaction),
            onClickDelete: () async {
              await CustomAlertDialog.customAlertButton(context, () => onClickDelete(transaction.id), 'Do you want to delete?', 'Yes', 'No');
            }
          );
        },
    );
  }
  void onClickEdit(Expenses transaction){
    Get.to(()=>AddTransaction(
      expenseId: transaction.id,
      initialItemName: transaction.name,
      initialDescription: transaction.description,
      initialAmount: transaction.amount.toString(),
      selectedDate: DateTime.parse(transaction.date),
      selectedCategory: transaction.category,
      newMode: false,
    ));
  }

  Future<void> onClickDelete(String id) async {
    setState(() {
      isLoading=true;
    });
    List<String>result=await TransactionController.deleteExpense(id);
    setState(() {
      isLoading=false;
    });
    await CustomUserMessage.sendMessage(result[1]);
    if(result[0]=='200'){
      Get.offAll(()=>TransactionHistory());
    }
  }
}
