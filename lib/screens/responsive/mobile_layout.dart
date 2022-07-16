import 'package:flutter/material.dart';
import 'package:m_c_e/screens/post/student_post_view_screen.dart';
import 'package:m_c_e/screens/profile/student_profile_mobile.dart';
import '../athentication_screens/welcome.dart';
import '../chats/main_chat.dart';
import '../user_type/admin.dart';
import '../user_type/student.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  final Screens = [
    StudentPostViewScreen(),
    MainChat(),
    StudentProfileMobile(),
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
