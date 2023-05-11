import 'package:flutter/material.dart';

import '../../Utils/CustomShapePainter.dart';

class CustomAccountCard extends StatelessWidget {
  String accountName;
  String accountNumber;
  String accountType;
  String accountBalance;
  String accountId;
  final Function()? onClickDelete;
  CustomAccountCard({Key? key,required this.accountId,required this.accountName,required this.accountNumber,required this.accountType,required this.accountBalance, required this.onClickDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Card(
      margin: const EdgeInsets.only(left: 10,right: 10,top: 20),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
      color: Colors.blue[100],
      elevation: 9,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            gradient: LinearGradient(
              colors: [Colors.blue,Colors.white],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 12,
                offset: Offset(0, 6),
              )
            ]),
        child: Stack(children: [
          Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: CustomPaint(
                size: Size(width*0.5,height*0.05),
                painter: CustomCardShapePainter(
                    24, Colors.white, Colors.blue),
              )),
          Column(
            children: [
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left:30,right:20,top:10),
                child: Row(
                  children: [
                    Text("Account Number:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                    const SizedBox(width: 10,),
                    Expanded(child: Text(accountNumber,style: TextStyle(fontSize: 20),)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30,right:20,top:10),
                child: Row(
                  children: [
                    Text("Account Name:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                    const SizedBox(width: 10,),
                    Expanded(child: Text(accountName,style: TextStyle(fontSize: 20),)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30,right:20,top:10),
                child: Row(
                  children: [
                    Text("Account Type:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                    const SizedBox(width: 10,),
                    Expanded(child: Text(accountType,style: TextStyle(fontSize: 20),)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30,right:20,top:10),
                child: Row(
                  children: [
                    Text("Balance:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                    const SizedBox(width: 10,),
                    Text(accountBalance+" Rs",style: TextStyle(fontSize: 20),),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        size: 20,
                      ),
                      onPressed: () async {
                        await onClickDelete!();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

