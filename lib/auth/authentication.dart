import 'dart:async';
import 'package:uuid/uuid.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:m_c_e/auth/show_snack_bar.dart';
import 'package:m_c_e/screens/user_type/user_type.dart';
import '../data_type/student_info.dart';
import '../screens/athentication_screens/signin.dart';
import '../screens/user_type/admin.dart';
import '../screens/user_type/student.dart';

class AuthenticationClass {


  late FirebaseAuth _auth;

  AuthenticationClass(this._auth);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  //Sign Up and Register your Mechatronics account with your e-mail and password
  Future<void> signUpWithEmail({
    required String userName,
    required String regNumber,
    required String level,
    required String email,
    required String password,
    required Uint8List imageFile,
    required BuildContext context,
  }) async {
    try {
      //Create Account for new User
      UserCredential credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String profilePics = await ConvertToStringAndDeployToStorage('Profile-Picture', imageFile, false);

      //Add users sign up infomation to their account
      StudentDetails User = StudentDetails(
        imageUrl: profilePics,
        userName: userName,
        email: email,
        regNumber: regNumber,
        level: level,
        password: password,
        UserID: _auth.currentUser!.uid,
      );

      await _firestore.collection('Users').doc(credentials.user!.uid).set(User.toJson(),);


      //Verify new users e-mail
      await sendEmailVerificationMessage(context);

      //Take New User to Signin Page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SigninPage(),
        ),
      );

      if (!_auth.currentUser!.emailVerified) {
        showSnackBar(context, "Verify your account with the link sent to you");
      }
    }

    // If Error Occurs, Display the message on SnackBar
    on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        showSnackBar(context, "Your Mechatronics account password is weak");
      }
      showSnackBar(context, error.message!);
    }
  }


  //Email Verification Function (This is the function that sends the user a mail to verify his/her e-mail on the mechatronics platform)
  Future<void> sendEmailVerificationMessage(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, "Email Verification has been sent");
    } on FirebaseException catch (error) {
      showSnackBar(context, error.message!);
    }
  }

  Future<void> resetPassword({required BuildContext context, required String Email}) async {
    try{
        if(Email != null) {
          _auth.sendPasswordResetEmail(email: Email);
          showSnackBar(context, "Reset Password request has been sent to this E-mail");
        }
    }on FirebaseException catch (error){
      showSnackBar(context, error.message!);
    }
  }


  // Log in With E-mail and Password into your Mechatronics account Function
  Future<void> signinWithEmail({
    required String regNumber,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);


      // The if(condition statement) is for checking if the user is verified and if not a verification message will be sent to that user
      if (_auth.currentUser!.emailVerified) {
        showSnackBar(context, "Welcome to the Mechatronics platform!");

        //Take New User to Home Page
        _auth.signInWithEmailAndPassword(email: email, password: password).then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Admin_Student(
          Admin(),
          Student(),
        ),),(route) => false));


      }
      else {
        await sendEmailVerificationMessage(context);
        showSnackBar(
            context, "Verify your account with the link sent to your e-mail");
      }
    } on FirebaseException catch (error) {
      showSnackBar(context, error.message!);
    }
  }

  //This is the function that uploads the image to the firebase storage and converts the image to a string to be stored in cloud firestore.

  Future<String> ConvertToStringAndDeployToStorage(String childName, Uint8List file, bool isPost) async {

    Reference ref = FirebaseStorage.instance.ref().child(childName).child(_auth.currentUser!.uid);

     if(isPost){
       String id = const Uuid().v1();
       ref = ref.child(id);
     }


    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

}