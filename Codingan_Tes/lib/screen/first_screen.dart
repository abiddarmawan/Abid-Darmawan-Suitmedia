import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:async';
import 'second_screen.dart';
class First_Screen extends StatelessWidget {
  First_Screen({ Key? key }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController palindrom = TextEditingController();
  bool isPalindrome(String cek) {
 
  cek = cek.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
  
  
  String kalimatterbalik = cek.split('').reversed.join('');
  
 
  if (cek == kalimatterbalik) {
    return true;
  } else {
    return false;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/background 1.png"),
          fit: BoxFit.cover)
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                     image: DecorationImage(image: AssetImage("images/ic_photo.png"),
                  fit: BoxFit.cover)
                  ),
                ),
                SizedBox(height: 60),
                Form(
                  key: _formKey,
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        TextFormField(
                                validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter name";
                                    }
                                    return null;
                                },
                                controller: name,
                                  autocorrect: false,
                                  keyboardType: TextInputType.name,  
                                  decoration: InputDecoration(
                                   filled: true,
                                   fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                    hintText: "Name",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.white, width: 3.0),
                                  ),
                                  
                                  )
                            ),
                            SizedBox(height: 10),
                        TextFormField(
                                validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter Palindrome";
                                    }
                                    return null;
                                },

                                controller: palindrom,
                                  autocorrect: false,
                                  keyboardType: TextInputType.name,  
                                  decoration: InputDecoration(
                                   filled: true,
                                   fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                    hintText: "Palindrome",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.white, width: 3.0),
                                  ),
                                  
                                  )
                            ),
              SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {
                    
                     if (_formKey.currentState!.validate()){
                      bool cek = isPalindrome(palindrom.text);
                         if(cek) {
                              showDialog(context: context, builder: (context) => AlertDialog(
                                title: Text("Cek palindrome"),
                                content: Text("isPalindrome"),
                                actions: [
                                  ElevatedButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF2B637B),
                                    
                                    ),child: Text("cancel"))
                                ],
                              ));
                          }else{
                             showDialog(context: context, builder: (context) => AlertDialog(
                                content: Text("not palindrome"),
                              title: Text("Cek palindrome"),
                                actions: [
                                  ElevatedButton(onPressed: (){
                                  
                                    Navigator.pop(context);
                                  },   
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF2B637B),
                                    
                                    ),
                                  child: Text("cancel"))
                                ],
                              ));
                          };
                       
                     
                 }
                  },
                  style: ElevatedButton.styleFrom(
                        minimumSize: Size(350, 10), 
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      backgroundColor: Color(0xFF2B637B),
                     
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                  child: Text('CHECK'),
                ),
            SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    
                     if (_formKey.currentState!.validate()){
                      
                       Navigator.push(context, MaterialPageRoute(builder: (context) => Second_Screen(
                         name: name.text,
                       )));
                     
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2B637B),
                      minimumSize: Size(350, 10), 
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                  child: Text('NEXT'),
                ),
                    ],
                  ),
                )
            ],
          ),
          )
        ),
    );
  }
}