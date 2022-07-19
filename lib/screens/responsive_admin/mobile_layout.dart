import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_c_e/screens/athentication_screens/welcome.dart';
import 'package:m_c_e/screens/chats/complaint_box.dart';
import 'package:m_c_e/screens/chats/main_chat.dart';
import 'package:m_c_e/screens/profile/admin_search_profile.dart';
import 'package:m_c_e/screens/profile/student_profile_edit.dart';
import 'package:m_c_e/screens/user_type/admin.dart';
import 'package:m_c_e/screens/user_type/student.dart';

import '../chats/admin_main_chat.dart';
import '../post/admin_post_screen.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {

  final Screens = [
    AdminPostScreen(),
    AdminMainChat(),
    AdminSearchProfile(),
  ];

  int _page = 0;
   void button (int index){
     setState(() {
       _page = index;
     });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screens[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        onTap: button,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.newspaper,), label: "What's up!",),
          BottomNavigationBarItem(icon: Icon(Icons.chat,), label: 'Chats/Complaints',),
          BottomNavigationBarItem(icon: Icon(Icons.person,), label: 'Profile',)
        ],
      ),
    );
  }
}
