import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:tes_suitmedia/screen/first_screen.dart';
import 'package:tes_suitmedia/screen/second_screen.dart';
import '../models/User.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
class Third_Screen extends StatefulWidget {
  final String name;
  final String selecteduser;
  Third_Screen({Key? key, @required this.name = "",this.selecteduser =""}) : super(key: key);

  @override
  State<Third_Screen> createState() => _Third_ScreenState();
}

class _Third_ScreenState extends State<Third_Screen> {
  List<User> users = [];
  int page = 1;
  bool cek = false;
  RefreshController refreshC = RefreshController();
  Future fetchData() async {
    
    final response = await http.get(Uri.parse("https://reqres.in/api/users?page=$page&per_page=3"));
   
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
       if (mounted) {
        setState(() {
          if (data.length > 0) {
            for (var datajson in data) {
              User datauser = User.fromJson(datajson);
              users.add(datauser);
            }
          } else {
            cek = true;
          }
        });
      }
      
      
    }
  }

  void refreshData() async {
    await Future.delayed(Duration(seconds: 1));
    users.clear();
    setState(() {
      page++;
    });
    
    
    await fetchData();
   
    refreshC.refreshCompleted();
  }

 

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF554AF0),
          ),
          onPressed: () {
          
            if(widget.selecteduser == ""){
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Second_Screen(
                  name: widget.name,
              )));
            }
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Second_Screen(
                  name: widget.name, selecteduser: widget.selecteduser,
              )));
          },
        ),
        title: Text("Third Screen",
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SmartRefresher(
        controller: refreshC,
        onRefresh: refreshData,
        child: 
        cek ? 
       AlertDialog(
          title: Text("Data Kosong"),
          content: Text("Data Telah Kosong"), 
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2B637B),

              ),
              onPressed: ()  {
                  
            if(widget.selecteduser == ""){
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Third_Screen(
                  name: widget.name,
                    )));
                  }
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Third_Screen(
                        name: widget.name, selecteduser: widget.selecteduser,
                    )));
          
              },
              child: Text("back to page 1"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2B637B),

              ),
              onPressed: () {
              if(widget.selecteduser == ""){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Second_Screen(
                        name: widget.name,
                    )));
                  }
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Second_Screen(
                  name: widget.name, selecteduser: widget.selecteduser,
              )));
              },
              child: Text("Back to second_screen"),
            ),
          ],
        )
        :
        ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {

             if(users.length == 0) {
               return Center(
                 child : 
                 Text("Data Kosong")
               );
             }else {
              final user = users[index];
              return  Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(
                    color: Colors.black,
                    width: 0.1
                  ))
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: ClipOval(child: Image.network('${user.avatar}',fit: BoxFit.cover,)),
                  ),
                  title: Text(
                    user.firstName + " " + user.lastName,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  subtitle: Text(
                    user.email,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    
                    ),
                  ),
                  onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Second_Screen(
                  name: widget.name, selecteduser: user.firstName + " " + user.lastName,
              )));
                  },
                ),
              );
              
             }
            
            }
          
        ),
      ),
    );
  }


}
