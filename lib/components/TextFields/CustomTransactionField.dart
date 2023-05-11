import 'package:flutter/material.dart';

class CustomTransactionField extends StatefulWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const CustomTransactionField({Key? key, this.controller, required this.hintText, required this.obscureText}) : super(key: key);

  @override
  State<CustomTransactionField> createState() => _CustomTransactionFieldState();
}

class _CustomTransactionFieldState extends State<CustomTransactionField> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white70),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: widget.hintText
        ),
      ),
    );
  }
}

