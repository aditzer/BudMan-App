import 'package:budman_app/components/Buttons/CustomButton.dart';
import 'package:budman_app/components/TextFields/CustomTextfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/Authentication.dart';
import '../components/Toasts/CustomUserMessage.dart';
import 'DashBoard.dart';
import 'RegisterPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading=false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body:isLoading? const Center(child: CircularProgressIndicator()):  ListView(
          children:[
            SafeArea(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Text(
                      "Hi, Welcome Back!",
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
                      "Sign in to BudMan",
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
                          "Don’t have an account? ",
                          style: GoogleFonts.publicSans(fontSize: 15),
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Get Started",
                                style: GoogleFonts.publicSans(
                                    fontSize: 15, color: Colors.blue),
                                recognizer: TapGestureRecognizer()..onTap = () {Get.to(RegisterPage());})),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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
                      height: 25,
                    ),
                    CustomButton(buttonText: "Login",onTap: onClickLogin,),
                    SizedBox(height: height*0.05,)
                  ],
                ),
              ),
            ),
          ]
      ),
    );
  }
  Future<void> onClickLogin() async {
    String email=emailController.text;
    String password=passwordController.text;
    if(!email.isEmail){
      await CustomUserMessage.sendMessage("Invalid email!");
      return;
    }
    else if(password.length<8){
      await CustomUserMessage.sendMessage("Password must have at least 8 digits!");
      return;
    }
    setState(() {
      isLoading=true;
    });
    List<String> response=await Authentication.login(email, password);
    CustomUserMessage.sendMessage(response[1]);
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

