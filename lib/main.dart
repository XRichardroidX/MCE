import 'package:flutter/material.dart';
import 'package:m_c_e/screens/athentication_screens/signin.dart';
import 'package:m_c_e/screens/athentication_screens/signup.dart';
import 'package:m_c_e/screens/athentication_screens/welcome.dart';
import 'package:m_c_e/screens/responsive/responsive_layout.dart';
import 'package:m_c_e/screens/responsive/mobile_layout.dart';
import 'package:m_c_e/screens/responsive/web_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:m_c_e/auth/authentication.dart';
import 'package:m_c_e/screens/user_type/admin.dart';
import 'package:m_c_e/screens/user_type/student.dart';
import 'package:m_c_e/screens/user_type/user_type.dart';
import 'package:provider/provider.dart';
import 'package:auth/auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'database/database.dart';
import 'firebase_options.dart';

// ...
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}




class MainApp extends StatelessWidget {
  MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mechatronics Department',
      home: Home(),
    );
  }
}


class Home extends StatefulWidget {

   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    Scaffold(body: Center(child: Text('ready in 3...'),),);
    await Future.delayed(const Duration(seconds: 1));
    Scaffold(body: Center(child: Text('ready in 2...'),),);
    await Future.delayed(const Duration(seconds: 1));
    Scaffold(body: Center(child: Text('ready in 1...'),),);
    await Future.delayed(const Duration(seconds: 1));
    Scaffold(body: Center(child: Text('Go...!'),),);
    FlutterNativeSplash.remove();
  }

  bool? verifiedEmail = FirebaseAuth.instance.currentUser?.emailVerified;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(verifiedEmail == null){
          verifiedEmail = false;
        }
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            if (verifiedEmail!) {
              return Admin_Student(
                Admin(),
                Student(),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const WelcomePage();
      },
    );
  }
}
