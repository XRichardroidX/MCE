import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:m_c_e/auth/authentication.dart';


class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _registrationNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _resetPasswordEmailController = TextEditingController();
  bool hidePassword = true;
  String passwordTxt = "See password";

  @override
  void dispose() {
    super.dispose();
    _registrationNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _resetPasswordEmailController.dispose();
  }

  void signinUser() async {
    AuthenticationClass(FirebaseAuth.instance).signinWithEmail(
        context: context,
        regNumber: _registrationNumberController.text.trim(),
        password: _passwordController.text.trim(),
        email: _emailController.text.trim(),
    );
  }

  void resendEmailVerificationMessage() async {
    await AuthenticationClass(FirebaseAuth.instance)
      .sendEmailVerificationMessage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(child: Text('Sign in')),
        elevation: 0,
        actions: [
          IconButton(
            icon: Image.asset('assets/futo_logo.png'),
            onPressed: null,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 8.0),
              TextField(
                controller: _registrationNumberController,
                  cursorHeight: 0,
                  cursorWidth: 0,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'Reg No.',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _emailController,
                cursorHeight: 0,
                cursorWidth: 0,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'E-mail',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                obscureText: hidePassword,
                controller: _passwordController,
                cursorHeight: 0,
                cursorWidth: 0,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Password',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: (){
                      showDialog(
                          context: context, builder: (context) {
                        return AlertDialog(
                          title: Text(
                              "This will reset your Mechatronics account password",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          ),
                          content: TextField(
                            controller: _resetPasswordEmailController,
                            autofocus: true,
                            decoration: InputDecoration(hintText: "Enter your Email address"),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  AuthenticationClass(FirebaseAuth.instance).resetPassword(context: context, Email: _resetPasswordEmailController.text.trim());
                                  Navigator.of(context).pop();
                                  _resetPasswordEmailController.text = "";
                                },
                                child: Text('RESET PASSWORD')
                            ),
                          ],
                        );
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
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
                            color: Colors.green,
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
                ],
              ),


              SizedBox(
                height: 65,
              ),
              MaterialButton(
                child: Text(
                  'Sign in',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                  ),
                ),
                height: 60.0,
                minWidth: 300.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(
                    color: Colors.green,
                  ),
                ),
                onPressed: signinUser,
                color: Colors.white,
              ),
              SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Click here to ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                    onTap: resendEmailVerificationMessage,
                    child: Text(
                      "verify your account",
                      style: TextStyle(color: Colors.lightGreen),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
