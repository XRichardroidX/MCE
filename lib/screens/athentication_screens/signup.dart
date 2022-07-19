import 'dart:typed_data';
import 'package:m_c_e/database/database.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:m_c_e/auth/authentication.dart';
import 'package:m_c_e/auth/show_snack_bar.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _registrationNumberController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  bool hidePassword = true;
  String passwordTxt = "See password";

  // premium4oxide@gmail.com
  @override
     Uint8List? _profilePics;
  Future selectProfileImage() async {
    return showDialog(context: context, builder: (context){
      return SimpleDialog(
        title: const Text("Add a profile photo of yourself"),
        children: [
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Take a photo"),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await Database().pickImage(ImageSource.camera);
              setState(() {
                _profilePics = file;
              });
            },
          ),
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Choose from gallery"),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await Database().pickImage(ImageSource.gallery,);
              setState(() {
                _profilePics = file;
              });
            },
          ),
        ],
      );
    });
  }

  void signupUser() async {
    if (_userNameController.text.trim() == null || _registrationNumberController.text.trim() == null || _levelController.text.trim() == null || _emailController.text.trim() == null || _passwordController.text.trim() == null || _profilePics == null) {
      showSnackBar(context, "Fill the empty field");
    }
    if (_passwordController1.text.trim() == _passwordController2.text.trim()) {

        _passwordController = _passwordController1;

      AuthenticationClass(FirebaseAuth.instance).signUpWithEmail(
          context: context,
          userName: _userNameController.text.trim(),
          regNumber: _registrationNumberController.text.trim(),
          level: _levelController.text.trim(),
          password: _passwordController.text.trim(),
          email: _emailController.text.trim(),
          imageFile: _profilePics!,
      );
    }
    else {
        showSnackBar(context, "You typed in two different passwords");
      }

  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordController1.dispose();
    _passwordController2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Center(child: Text('Sign up')),
          elevation: 0,
          actions: [
           IconButton(
              icon: Image.asset('assets/futo_logo.jpg'),
              onPressed: null,
            ),
         ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 8,),
              Stack(
              children: <Widget>[
                  _profilePics != null ?
                  CircleAvatar(
                    radius: 58,
                    backgroundImage: MemoryImage(_profilePics!),
                  )
                      : const CircleAvatar(
                    radius: 58,
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5x4WvEaZ3xMfEabrEaxND9kL0jYbKEU-BJw&usqp=CAU"
                    ),
                  ),
                  Positioned(
                    bottom: -15,
                    right: -5,
                    child: IconButton(
                      onPressed: (){
                        selectProfileImage();
                      },
                      icon: Icon(
                        Icons.add_a_photo,
                        //  color: Colors.white),
                       ),
                      ),
                     ),
                    ],
                   ),
                  SizedBox(height: 8,),
                  TextField(
                    controller: _userNameController,
                    cursorHeight: 0,
                    cursorWidth: 0,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: _registrationNumberController,
                    cursorHeight: 0,
                    cursorWidth: 0,
                    decoration: InputDecoration(
                        fillColor: Colors.red,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'Reg NO.'),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: _levelController,
                    cursorHeight: 0,
                    cursorWidth: 0,
                    decoration: InputDecoration(
                        fillColor: Colors.red,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'Level'),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: _emailController,
                    cursorHeight: 0,
                    cursorWidth: 0,
                    decoration: InputDecoration(
                        fillColor: Colors.red,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'E-mail'),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: _passwordController1,
                    cursorHeight: 0,
                    cursorWidth: 0,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'Password',
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: _passwordController2,
                    cursorHeight: 0,
                    cursorWidth: 0,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'Confirm Password',
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      if(hidePassword == true){
                        setState(() {
                          hidePassword = false;
                          passwordTxt = "Hide password";
                        });
                      }
                      else{
                        setState(() {
                          hidePassword = true;
                          passwordTxt = "See password";
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: AlignmentDirectional.centerEnd,
                            child: Text(
                                "$passwordTxt",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 70.0),
                  MaterialButton(
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                    height: 60.0,
                    minWidth: 300.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: signupUser,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
        ),
        ),
    );
   }
}
