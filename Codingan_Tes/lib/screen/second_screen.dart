import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'third_screen.dart';
class Second_Screen extends StatefulWidget {

  final String name;
  final String selecteduser;
  const Second_Screen({ Key? key,@required this.name = "",this.selecteduser =""}) : super(key: key);

  @override
  _Second_ScreenState createState() => _Second_ScreenState();
}

class _Second_ScreenState extends State<Second_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF554AF0),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        title: Text("Second Screen", style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black
        )),
        backgroundColor: Colors.white,
        elevation: 0.5
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                children: [
                  Text("Welcome", style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  )),
                  Text(widget.name, style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  )),
                ],
              ),
            ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: widget.selecteduser == "" ?
              Text(
                "Selected User Name",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              )
              :
               Text(
                 widget.selecteduser,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              )
            ),
          ],
        ),
           ),
            ElevatedButton(
                  onPressed: () {
                     if(widget.selecteduser == "") {
                      
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Third_Screen(
                                              name: widget.name,
                       )));
                     }
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Third_Screen(
                        name: widget.name, selecteduser: widget.selecteduser,
                       )));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2B637B),
                      minimumSize: Size(350, 10), 
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
              child: Text(
                "Choose a User",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
              ),
                ),
          ],
        ),
        ),
    );
  }
}