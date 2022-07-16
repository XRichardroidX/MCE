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
import 'database/database.dart';
import 'firebase_options.dart';

// ...
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
       MainApp({super.key});
       bool? verifiedEmail = FirebaseAuth.instance.currentUser?.emailVerified;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mechatronics Department',
      home: StreamBuilder(
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
      ),
    );
  }
}
