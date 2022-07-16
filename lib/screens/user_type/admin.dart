import 'package:flutter/material.dart';

import '../responsive_admin/responsive_layout.dart';
import '../responsive_admin/web_layout.dart';
import '../responsive_admin/mobile_layout.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileScreenLayout: MobileScreenLayout(),
      webScreenLayout: WebScreenLayout(),
    );
  }
}
