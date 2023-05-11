import 'package:flutter/material.dart';

class CustomProfileTextField extends StatelessWidget {
  String title;
  IconData iconData;
  TextEditingController controller;
  bool read;
  CustomProfileTextField({Key? key,required this.title,required this.iconData,required this.controller,required this.read}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
        padding:EdgeInsets.symmetric(horizontal: width*0.1),
        child: TextFormField(
          controller: controller,
          readOnly: read,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            filled: true,
            fillColor: read?Colors.grey[400]:Colors.white,
            prefixIcon: Icon(iconData,color: Colors.black,),
            label: Text(title,style: const TextStyle(color: Colors.black),),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(color: Colors.black)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(color: Colors.black)
            ),
          ),
        ),
    );
  }
}
