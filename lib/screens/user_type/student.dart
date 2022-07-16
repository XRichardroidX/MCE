import 'package:flutter/material.dart';

import '../responsive/mobile_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_layout.dart';

class Student extends StatefulWidget {
  const Student({Key? key}) : super(key: key);

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileScreenLayout: MobileScreenLayout(),
      webScreenLayout: WebScreenLayout(),
    );
  }
}
