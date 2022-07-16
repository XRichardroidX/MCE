import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_c_e/screens/profile/admin_search_profile.dart';

import '../athentication_screens/welcome.dart';
import '../chats/main_chat.dart';
import '../post/admin_post_screen.dart';
import '../user_type/admin.dart';
import '../user_type/student.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  final Screens = [
    AdminPostScreen(),
    MainChat(),
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
