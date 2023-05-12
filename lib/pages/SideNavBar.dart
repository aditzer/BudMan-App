import 'package:budman_app/data/DataStore.dart';
import 'package:budman_app/data/FetchData.dart';
import 'package:budman_app/pages/AccountDetailsPage.dart';
import 'package:budman_app/pages/AddGoals.dart';
import 'package:budman_app/pages/AddTransaction.dart';
import 'package:budman_app/pages/ChangePassword.dart';
import 'package:budman_app/pages/DashBoard.dart';
import 'package:budman_app/pages/MyGoals.dart';
import 'package:budman_app/pages/MyProfile.dart';
import 'package:budman_app/pages/LoginPage.dart';
import 'package:budman_app/pages/TransactionHistory.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/User.dart';
import 'AddAccount.dart';
import 'DeepAnalysis.dart';

class SideNavBar extends StatefulWidget {
  const SideNavBar({Key? key}) : super(key: key);

  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  User user=User("null","null","null","null","null",[],0,[],[]);

  Future<User> getData() async {
    user=await FetchData.fetchStoredData();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<User>snapshot){
        if (snapshot.hasData){
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: height*0.3,
                  child: DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.black,
                              radius:width*0.125,
                              child: ClipOval(
                                child: SizedBox(
                                  child: Image.asset("assets/images/budman_user_logo.jpeg"),
                                ),
                              )
                          ),
                          SizedBox(height: height*0.025),
                          Text(user.name,
                            style: GoogleFonts.publicSans(fontSize: 25,color: Colors.white),
                          ),
                          SizedBox(height: height*0.01),
                        ],
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.plus,color: Colors.green,),
                  title: Text('Add Transaction',style: TextStyle(fontSize: 17),),
                  onTap: () => Get.offAll(()=>AddTransaction(
                    expenseId:"",
                    initialAmount: "",
                    initialItemName: "",
                    initialDescription: "",
                    selectedCategory: "Bills",
                    selectedDate: DateTime.now(),
                    newMode: true,
                  )),
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.piggyBank,color: Colors.orange,),
                  title: Text('Add Account',style: TextStyle(fontSize: 17)),
                  onTap: () => Get.offAll(()=>AddAccount()),
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.crosshairs,color: Colors.red,),
                  title: Text('Add Goals',style: TextStyle(fontSize: 17)),
                  onTap: () => Get.offAll(()=>AddGoals()),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.dashboard,color: Colors.blue,),
                  title: Text('DashBoard',style: TextStyle(fontSize: 17)),
                  onTap: () => Get.offAll(()=>DashBoardPage()),
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.indianRupeeSign,color: Colors.green),
                  title: Text('Transaction History',style: TextStyle(fontSize: 17)),
                  onTap: () => Get.offAll(()=>TransactionHistory()),
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.chartLine,color: Colors.blue,),
                  title: Text('Deep Analysis',style: TextStyle(fontSize: 17)),
                  onTap: ()=>Get.offAll(()=>DeepAnalysis(),),
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.suitcase,color: Colors.orange),
                  title: Text('My Accounts',style: TextStyle(fontSize: 17)),
                  onTap: () => Get.offAll(()=>AccountDetailsPage()),
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.bullseye,color: Colors.red,),
                  title: Text('My Goals',style: TextStyle(fontSize: 17)),
                  onTap: () => Get.offAll(()=>MyGoals()),
                ),
                Divider(),
                ListTile(
                  leading: Icon(FontAwesomeIcons.user,color: Colors.black,),
                  title: Text('My Profile',style: TextStyle(fontSize: 17)),
                  onTap: () => Get.offAll(()=>MyProfile(name: user.name, email: user.email, mobile: user.contact)),
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.lock,color: Colors.black),
                  title: Text('Change Password',style: TextStyle(fontSize: 17)),
                  onTap: () => Get.offAll(()=>ChangePassword()),
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.rightFromBracket,color: Colors.black),
                  title: Text('Logout',style: TextStyle(fontSize: 17)),
                  onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Do you want to logout?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async{
                            const Center(child: CircularProgressIndicator());
                            await DataStore.deleteData();
                            Navigator.pop(context, 'Yes');
                            Get.offAll(()=>LoginPage());
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

}
