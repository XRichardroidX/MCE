import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_c_e/screens/chats/admin_chat_room.dart';
import 'package:m_c_e/screens/chats/complaint_box.dart';
import 'package:m_c_e/screens/chats/student_chat_zone.dart';

class MainChat extends StatelessWidget {
  const MainChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Expanded(
              child: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ComplaintBox()),
                );
              },
              child: Container(
                 // oguzieibehrichard@gmail.com
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.height/5,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "Complaint Box!", style: GoogleFonts.cairo(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                   ),
                  ),
                ),
              ),
                ),
            ),
            Expanded(child:
                InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlertDialog(title: Text("You are not authorized as a Student to enter this chat room"),  ),),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.height/5,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text("     Head of Office \n                & \n Mechatronics Staffs",style: GoogleFonts.oxygen(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
              ),
            ),
           ),
            Expanded(
              child: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentChatZone()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.height/5,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "Student Zone",
                    style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
             ),
            ),
          ],
        ),
      ),
    );
  }
}
