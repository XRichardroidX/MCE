import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:m_c_e/screens/profile/student_profile_edit.dart';
import '../../database/database.dart';
import '../athentication_screens/welcome.dart';

class AdminSearchProfile extends StatefulWidget {
  const AdminSearchProfile({Key? key}) : super(key: key);

  @override
  State<AdminSearchProfile> createState() => _AdminSearchProfileState();
}

class _AdminSearchProfileState extends State<AdminSearchProfile> {

  bool isSearching = false;

   Stream? userRegNumber;

  TextEditingController searchUserRegNumberEditingController = TextEditingController();

  onSearchButtonClick() async
  {
    setState(() {isSearching = true;});
    userRegNumber = await Database().getUserByRegNumber(searchUserRegNumberEditingController.text);
  }

  Widget getStudentProfile()
  {
    return StreamBuilder(
        stream: userRegNumber,
      builder: (context, snapshot){
          return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
              DocumentSnapshot ds = snapshot.data.docs[index];
              return displayStudentProfile(profileUrl: ds["profileUrl"], Name: ds["Name"], Level: ds['Level'], Reg_Number: ds['Reg-Number'], UserID: ds['UserID']);
            },
          )
          :
            Center(
              child: Text('Search for your students with their FUTO Registration Number',style: TextStyle(color: Colors.grey),),
            );
      },
    );
  }

  Widget displayStudentProfile({String? profileUrl, Name, Level, Reg_Number, UserID}){
   return GestureDetector(
     onTap: (){
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => StudentProfileEdit(UserID: UserID,)),
       );
     },
     child: Row(
       children: [
         ClipRRect(
           borderRadius: BorderRadius.circular(40),
           child: Image.network(
             profileUrl!,
             height: 70,
             width: 70,
           ),
         ),
         SizedBox(width: 12,),
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text("Name: $Name"), Text("Level: $Level Level"),Text("Reg-NO.: $Reg_Number"),
           ],
         ),
       ],
     ),
   );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Admin Panel'),),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 19.0),
        child: Column(
          children: [
            Row(
              children: [
                isSearching
                    ?
                GestureDetector(
                  onTap: (){
                    isSearching = false;
                    setState(() {searchUserRegNumberEditingController.text = "";});
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Icon(Icons.arrow_back),
                  ),
                )
                    :
                Container(),
                SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 16.0),
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: searchUserRegNumberEditingController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Student Reg Number",
                              ),
                            ),
                        ),
                        GestureDetector(
                          onTap: (){
                            if(searchUserRegNumberEditingController.text != ""){
                              onSearchButtonClick();
                            }
                          },
                            child: Icon(Icons.search),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            getStudentProfile(),
          ],
        ),
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
    );
  }
}
