import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCard extends StatefulWidget {
  Color color;
  Color backgroundShadeColor;
  int money;
  IconData icon;
  String title;
  CustomCard({Key? key, required this.color, required this.money,required this.icon,required this.backgroundShadeColor,required this.title}) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 30,
      shadowColor: widget.color,
      color: widget.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        height: height * 0.20,
        width: width * 0.45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height*0.04),
                  child: CircleAvatar(
                    backgroundColor: widget.backgroundShadeColor,
                    radius: 27,
                    child: Center(
                      child: Icon(
                        widget.icon,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

            ]),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  widget.money.toString()+" Rs",
                  style: GoogleFonts.publicSans(fontSize: 15,fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                widget.title,
                style: GoogleFonts.publicSans(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
