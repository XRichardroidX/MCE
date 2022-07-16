import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:m_c_e/screens/user_type/admin.dart';
import 'package:m_c_e/screens/user_type/student.dart';

import '../../auth/authentication.dart';

// Checking Cloud FirebaseFirestore for reg_number to sign User in as either an Admin or a Student.

class Admin_Student extends StatelessWidget {
   Widget adminScreen;
   Widget studentScreen;

         Admin_Student(this.adminScreen, this.studentScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          // Checking if future is resolved or not
          if (snapshot.connectionState == ConnectionState.done) {
            // If we got an error
            final data = snapshot.data as String;
            if('$data' == '1234567890'){
              return adminScreen;
            }
            return studentScreen;
          }
          // Displaying LoadingSpinner to indicate waiting state
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        // inorder to display something on the Canvas
        future: getRegNumber(),
      ),
    );
  }
}







    User? cred = FirebaseAuth.instance.currentUser;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<String> getRegNumber() async {
      var snapShot = await _firestore.collection('Users').doc(cred!.uid).get();
      String? regNumber;
      if (snapShot.exists) {
        Map<String, dynamic> data = snapShot.data()!;
        regNumber = data['Reg-Number'];
      }
      return regNumber!;
    }
