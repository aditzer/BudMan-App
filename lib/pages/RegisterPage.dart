import 'package:budman_app/controller/Authentication.dart';
import 'package:budman_app/components/Toasts/CustomUserMessage.dart';
import 'package:budman_app/pages/DashBoard.dart';
import 'package:budman_app/pages/LoginPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/Buttons/CustomButton.dart';
import '../components/TextFields/CustomTextfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading=false;
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body:isLoading? const Center(child: CircularProgressIndicator()): ListView(
          children:[
            SafeArea(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Text(
                      "Hi, Welcome!",
                      style: GoogleFonts.publicSans(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset("assets/images/budman_login.png",height: height*0.3,),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Register on BudMan",
                      style: GoogleFonts.publicSans(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have an account? ",
                          style: GoogleFonts.publicSans(fontSize: 15),
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Login",
                                style: GoogleFonts.publicSans(
                                    fontSize: 15, color: Colors.blue),
                                recognizer: TapGestureRecognizer()..onTap = () {Get.to(LoginPage());})),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextfield(
                      controller: usernameController,
                      hintText: "Full name",
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: emailController,
                      hintText: "Email",
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: mobileNoController,
                      hintText: "Mobile No.",
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(buttonText: "Register",onTap: onClickRegister,),
                    SizedBox(height: height*0.05,)
                  ],
                ),
              ),
            ),
          ]
      ),
    );
  }
  Future<void> onClickRegister() async {
    String email=emailController.text;
    String username=usernameController.text;
    String password=passwordController.text;
    String mobile=mobileNoController.text;

    if(!email.isEmail){
      await CustomUserMessage.sendMessage("Invalid email!");
      return;
    }
    else if(username.isEmpty){
      await CustomUserMessage.sendMessage("Enter Username!");
      return;
    }
    else if(password.length<8){
      await CustomUserMessage.sendMessage("Password must have at least 8 digits!");
      return;
    }
    setState(() {
      isLoading=true;
    });
    List<String> response=await Authentication.register(username, email, password, mobile);
    if(response[0]=="200"){
      Get.offAll(() => DashBoardPage());
    }
    else{
      setState(() {
        isLoading=false;
      });
    }
  }
}
