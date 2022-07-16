import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../athentication_screens/welcome.dart';

class StudentProfileMobile extends StatefulWidget {
  const StudentProfileMobile({Key? key}) : super(key: key);

  @override
  State<StudentProfileMobile> createState() => _StudentProfileMobileState();
}

class _StudentProfileMobileState extends State<StudentProfileMobile> {

  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(4, 9, 35, 1),
                Color.fromRGBO(39, 105, 171, 1),
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder<DocumentSnapshot>(
            future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
            builder:
                (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return Text("Document does not exist");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Federal  University  of  Technology, Owerri \n Mechatronics  Department",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'Nisebuschgardens',
                              ),
                            ),
                            SizedBox(height: 22,),
                            Container(
                              height: height * 0.43,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  double innerHeight = constraints.maxHeight;
                                  double innerWidth = constraints.maxWidth;
                                  return Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          height: innerHeight * 0.70,
                                          width: innerWidth,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                30),
                                            color: Colors.white,
                                          ),
                                          child: SizedBox(
                                            height: innerHeight * 0.72,
                                            width: innerWidth,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Name: ",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15,
                                                        fontFamily: 'Nisebuschgardens',
                                                      ),
                                                    ),
                                                    Text(
                                                      "${data['Name']}",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'Nisebuschgardens',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Reg Number: ",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15,
                                                        fontFamily: 'Nisebuschgardens',
                                                      ),
                                                    ),
                                                    Text(
                                                      "${data['Reg-Number']}",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'Nisebuschgardens',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Email: ",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15,
                                                        fontFamily: 'Nisebuschgardens',
                                                      ),
                                                    ),
                                                    Text(
                                                      "${data['E-mail']}",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'Nisebuschgardens',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Level:         ",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15,
                                                        fontFamily: 'Nisebuschgardens',
                                                      ),
                                                    ),
                                                    Text(
                                                      "${data['Level']} Level",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'Nisebuschgardens',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Todo Student Profile Picture
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        child: Center(
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(data['profileUrl'],), radius: 60,),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 50,),

                            //Todo Result GridView
                            Container(
                              height: height * 1.8,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),

                                    //Todo 100 Level Result Text
                                    Text(
                                      '100 Level Result',
                                      style: TextStyle(
                                        color: Color.fromRGBO(39, 105, 171, 1),
                                        fontSize: 27,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),

                                    Divider(
                                      thickness: 2.5,
                                    ),

                                    SizedBox(
                                      height: 16,
                                    ),


                                    //Todo Harmattan Semester
                                    Container(
                                      height: height * 0.8,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                height: 60,
                                                width: width * .8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("MTH 101", style: TextStyle(color: Colors.white),),
                                                    Text("${data['MTH101']}", style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                height: 60,
                                                width: width * .8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("PHY 101", style: TextStyle(color: Colors.white),),
                                                    Text("${data['PHY101']}", style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                height: 60,
                                                width: width * .8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("CHM 101", style: TextStyle(color: Colors.white),),
                                                    Text("${data['CHM101']}", style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                height: 60,
                                                width: width * .8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("BIO 101", style: TextStyle(color: Colors.white),),
                                                    Text("${data['BIO101']}", style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                height: 60,
                                                width: width * .8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("ENG 101", style: TextStyle(color: Colors.white),),
                                                    Text("${data['ENG101']}", style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                height: 60,
                                                width: width * .8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("ENG 103", style: TextStyle(color: Colors.white),),
                                                    Text("${data['ENG103']}", style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                height: 60,
                                                width: width * .8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("GST 101", style: TextStyle(color: Colors.white),),
                                                    Text("${data['GST101']}", style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                height: 60,
                                                width: width * .8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("GST 103", style: TextStyle(color: Colors.white),),
                                                    Text("${data['GST103']}", style: TextStyle(color: Colors.white),),
                                                    ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                height: 60,
                                                width: width * .8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("FRN/IGB 101", style: TextStyle(color: Colors.white),),
                                                    Text("${data['FRNIGB101']}", style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),


                                    SizedBox(
                                      height: 10,
                                    ),


                                    //Todo Rain Semester
                                    Container(
                                      height: height * 0.8,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                height: 60,
                                                width: width * .8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("MTH 102", style: TextStyle(color: Colors.white),),
                                                    Text("${data['MTH102']}", style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                height: 60,
                                                width: width * .8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("PHY 102", style: TextStyle(color: Colors.white),),
                                                    Text("${data['PHY102']}", style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                height: 60,
                                                width: width * .8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("CHM 102", style: TextStyle(color: Colors.white),),
                                                    Text("${data['CHM102']}", style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                height: 60,
                                                width: width * .8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("ENG 102", style: TextStyle(color: Colors.white),),
                                                    Text("${data['ENG102']}", style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                height: 60,
                                                width: width * .8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("ENG 104", style: TextStyle(color: Colors.white),),
                                                    Text("${data['ENG104']}", style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                height: 60,
                                                width: width * .8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("GST 102", style: TextStyle(color: Colors.white),),
                                                    Text("${data['GST102']}", style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                height: 60,
                                                width: width * .8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("GST 108", style: TextStyle(color: Colors.white),),
                                                    Text("${data['GST108']}", style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                height: 60,
                                                width: width * .8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("GST 110", style: TextStyle(color: Colors.white),),
                                                    Text("${data['GST110']}", style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 15),
                                                height: 60,
                                                width: width * .8,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("FRN/IGB 102", style: TextStyle(color: Colors.white),),
                                                    Text("${data['FRNIGB102']}", style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 30,),
                            //Todo 200Level
                            Container(
                              height: height * 0.5,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),

                                    //Todo 200 Level Result Text
                                    Text(
                                      '200 Level Result',
                                      style: TextStyle(
                                        color: Color.fromRGBO(39, 105, 171, 1),
                                        fontSize: 27,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),

                                    Divider(
                                      thickness: 2.5,
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),


                                    //Todo Harmattan Semester
                                    Container(
                                      height: height * 0.15,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),


                                    SizedBox(
                                      height: 10,
                                    ),


                                    //Todo Rain Semester
                                    Container(
                                      height: height * 0.15,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                    );
                  }
                  return Center(child: CircularProgressIndicator(),);
              },
             ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.logout),
            onPressed: (){
                  showDialog(context: context, builder: (BuildContext context){
                      return SimpleDialog(
                          title: const Text("Are you sure you want to sign out?"),
                           children: [
                                       SimpleDialogOption(
                                           padding: const EdgeInsets.all(20),
                                           child: const Text("Negative"),
                                           onPressed: () async {
                                           Navigator.of(context).pop();

                                           },
                                        ),
                                       SimpleDialogOption(
                                           padding: const EdgeInsets.all(20),
                                           child: const Text("Affirmative"),
                                           onPressed: () async {
                                           FirebaseAuth.instance.signOut().then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => WelcomePage()),(route) => false));
                                                          },
                                                        ),
                                                      ],
                                                   );
                                               });
                                            },
                      ),
            ),
          ],
        );
  }
}
