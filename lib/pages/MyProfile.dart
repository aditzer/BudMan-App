import 'package:budman_app/components/Buttons/CustomButton.dart';
import 'package:budman_app/components/TextFields/CustomProfileTextField.dart';
import 'package:budman_app/controller/UserInfoController.dart';
import 'package:budman_app/components/Toasts/CustomUserMessage.dart';
import 'package:budman_app/pages/SideNavBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/FetchData.dart';
import '../models/User.dart';
import 'DashBoard.dart';

class MyProfile extends StatefulWidget {
  String name, email, mobile;
  MyProfile(
      {Key? key, required this.name, required this.email, required this.mobile})
      : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool isLoading=false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  User user = User("null", "null", "null", "null", "null", [], 0,[],[]);
  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    emailController.text = widget.email;
    mobileController.text = widget.mobile;
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
            title: const Text("My Profile"),
          ),
          drawer: const SideNavBar(),
          body: isLoading? const Center(child: CircularProgressIndicator()): ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 10,
                    child: CircleAvatar(
                      radius: width * 0.175,
                      backgroundColor: Colors.grey,
                      child: ClipOval(
                          child: SizedBox(
                              child: Image.asset(
                                  "assets/images/budman_user_logo.jpeg"))),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Text(
                    "Edit Profile",
                    style: GoogleFonts.publicSans(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  CustomProfileTextField(
                    title: 'Full Name',
                    iconData: Icons.person,
                    controller: nameController,
                    read: false,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomProfileTextField(
                    title: 'Email',
                    iconData: Icons.email,
                    controller: emailController,
                    read: true,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomProfileTextField(
                    title: 'Contact',
                    iconData: Icons.phone,
                    controller: mobileController,
                    read: false,
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  CustomButton(buttonText: "Submit", onTap: onClickChangeProfile),
                ],
              ),
            ],
          ),
      ),
    );
  }
  Future<void> onClickChangeProfile() async {
    if (nameController.text.isEmpty) {
      CustomUserMessage.sendMessage("Name cannot be empty!");
      return;
    } else if (mobileController.text.isNotEmpty &&
        !mobileController.text.isNumericOnly) {
      CustomUserMessage.sendMessage("Invalid Phone no.!");
      return;
    } else {
      if (mobileController.text.isEmpty) {
        mobileController.text = "";
      }
      List<String> result;
      setState(() {
        isLoading=true;
      });
      result = await UserInfoController.updateProfile(nameController.text, emailController.text, mobileController.text);
      print(result[1]);
      user = await FetchData.fetchStoredData();
      CustomUserMessage.sendMessage(result[1]);
      setState(() {
        isLoading=false;
      });
      Get.offAll(()=>MyProfile(name: user.name, email: user.email, mobile: user.contact));
    }
  }
}
