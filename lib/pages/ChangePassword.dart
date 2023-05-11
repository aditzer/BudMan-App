import 'package:budman_app/components/Buttons/CustomButton.dart';
import 'package:budman_app/components/TextFields/CustomTextfield.dart';
import 'package:budman_app/controller/UserInfoController.dart';
import 'package:budman_app/components/Toasts/CustomUserMessage.dart';
import 'package:budman_app/pages/SideNavBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'DashBoard.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isLoading=false;
  TextEditingController oldPasswordController=TextEditingController();
  TextEditingController newPasswordController=TextEditingController();
  TextEditingController confirmNewPasswordController=TextEditingController();
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
          title: const Text("Change Password"),
        ),
        drawer: const SideNavBar(),
        body:isLoading? const Center(child: CircularProgressIndicator()):  ListView(
          children: [
            Column(
              children: [
                SizedBox(height: height*0.05,),
                Text("Change Password",style: GoogleFonts.publicSans(fontSize: 25,fontWeight: FontWeight.bold,)),
                SizedBox(height: height*0.05,),
                Icon(Icons.lock,color: Colors.black,size: height*0.15,),
                SizedBox(height: height*0.05,),
                CustomTextfield(hintText: "Enter Old Password", obscureText: true,controller: oldPasswordController,),
                SizedBox(height: height*0.02,),
                CustomTextfield(hintText: "Enter New Password", obscureText: true,controller: newPasswordController,),
                SizedBox(height: height*0.02,),
                CustomTextfield(hintText: "Confirm New Password", obscureText: true,controller: confirmNewPasswordController,),
                SizedBox(height: height*0.07,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width*0.05),
                  child: CustomButton(buttonText: "Change Password",onTap: onClickChangePassword,),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  Future<void> onClickChangePassword() async {
    if(oldPasswordController.text.length<8 || newPasswordController.text.length<8 || confirmNewPasswordController.text.length<8){
      CustomUserMessage.sendMessage("Password must have at least 8 length!");
      return;
    }
    else if(newPasswordController.text != confirmNewPasswordController.text){
      CustomUserMessage.sendMessage("New Password does not match!");
      return;
    }
    else{
      setState(() {
        isLoading=true;
      });
      List<String> result=await UserInfoController.changePassword(oldPasswordController.text, newPasswordController.text);
      oldPasswordController.text="";
      newPasswordController.text="";
      confirmNewPasswordController.text="";
      setState(() {
        isLoading=false;
      });
      CustomUserMessage.sendMessage(result[1]);
    }
  }
}
