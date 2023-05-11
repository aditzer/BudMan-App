import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Utils/CustomShapePainter.dart';


class CustomTransactionCard extends StatefulWidget {
  String name;
  int amount;
  String category;
  String description;
  String date;
  String id;
  final Function()? onClickEdit;
  final Function()? onClickDelete;
  CustomTransactionCard({Key? key,required this.id,required this.name,required this.amount,required this.category,required this.description,required this.date,required this.onClickEdit,required this.onClickDelete}) : super(key: key);
  @override
  State<CustomTransactionCard> createState() => _CustomTransactionCardState();
}

class _CustomTransactionCardState extends State<CustomTransactionCard> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Card(
      margin: const EdgeInsets.only(left: 10,right: 10,top: 20),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
      color: Colors.grey[100],
      elevation: 9,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            gradient: LinearGradient(
              colors: [Colors.grey,Colors.white],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
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
                    24, Colors.white, Colors.grey),
              )),
          Column(
            children: [
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left:30,right:20,top:10),
                child: Row(
                  children: [
                    Text("Name:",style: GoogleFonts.publicSans(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                    const SizedBox(width: 10,),
                    Expanded(child: Text(widget.name,style: GoogleFonts.publicSans(fontSize: 20),)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30,right:20,top:10),
                child: Row(
                  children: [
                    Text("Category:",style: GoogleFonts.publicSans(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                    const SizedBox(width: 10,),
                    Expanded(child: Text(widget.category,style: GoogleFonts.publicSans(fontSize: 20),)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30,right:20,top:10),
                child: Row(
                  children: [
                    Text("Description:",style: GoogleFonts.publicSans(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                    const SizedBox(width: 10,),
                    Expanded(child: Text(widget.description,style: GoogleFonts.publicSans(fontSize: 20),)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30,right:20,top:10),
                child: Row(
                  children: [
                    Text("Date:",style: GoogleFonts.publicSans(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                    const SizedBox(width: 10,),
                    Text(widget.date,style: GoogleFonts.publicSans(fontSize: 20),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30,right:20,top:10),
                child: Row(
                  children: [
                    Text("Amount:",style: GoogleFonts.publicSans(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                    const SizedBox(width: 10,),
                    Expanded(child: Text(widget.amount.toString(),style: GoogleFonts.publicSans(fontSize: 20),)),
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
                          Icons.edit,
                          size: 20,
                        ),
                        onPressed: (){
                          widget.onClickEdit!();
                        },
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.delete,
                          size: 20,
                        ),
                        onPressed: () async {
                          await widget.onClickDelete!();
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
