import 'package:auth/auth.dart';
import '../../database/database.dart';
import 'Package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

class StudentChatZone extends StatefulWidget {
  const StudentChatZone({Key? key}) : super(key: key);

  @override
  State<StudentChatZone> createState() => _StudentChatZoneState();
}

class _StudentChatZoneState extends State<StudentChatZone> {

  String UserID = FirebaseAuth.instance.currentUser!.uid;

  Future<Object> getUserNameForTexting() async {
    String Name;
    var SnapShot = await FirebaseFirestore.instance.collection("Users").doc(UserID).get();
    if(SnapShot != null){
      Map<String, dynamic> data = SnapShot.data()!;
      Name = data["Name"];
    }
    else{
      return Center(child: CircularProgressIndicator(),);
    }
    return Name;
  }

  Future<Object> getUserProfileUrlForTexting() async {
    String Name;
    var SnapShot = await FirebaseFirestore.instance.collection("Users").doc(UserID).get();
    if(SnapShot != null){
      Map<String, dynamic> data = SnapShot.data()!;
      Name = data["profileUrl"];
    }
    else{
      return Center(child: CircularProgressIndicator(),);
    }
    return Name;
  }



  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  var MyUserName;
  var ProfileUrl;
  String? messageID;

  getMessageDetails() async {
    MyUserName = await getUserNameForTexting();
    ProfileUrl = await getUserProfileUrlForTexting();
  }

  addMessage(bool sendClicked) async {
    if (messageController.text != null && ProfileUrl != null && MyUserName != null){

      String _messageController = messageController.text;
      var MessageSentTime = await DateTime.now();

      Map<String, dynamic> messageData = await {
        "Message" : _messageController,
        "SentBy" : MyUserName,
        "Time" : MessageSentTime,
        "ProfileUrl" : ProfileUrl,
      };


      messageID = randomAlphaNumeric(19);

      await Database().addStudentChatToDatabase(messageID!, messageData);

      if(sendClicked){
        messageController.text = "";
        messageID = null;
        sendClicked = false;
      }
    }
  }

  Widget displayComplaintsMessages(String Name, Complaint, Pix){
    if (Name == MyUserName) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      Pix,
                      height: 38,
                      width: 38,
                    ),
                  ),
                  SizedBox(width: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$Name",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 175,
                            child: Text(
                              "$Complaint",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      Pix,
                      height: 38,
                      width: 38,
                    ),
                  ),
                  SizedBox(width: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$Name",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 175,
                            child: Text(
                              "$Complaint",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
  Widget getComplaintsMessages() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('StudentChatRoom').orderBy('Time').snapshots(),
        builder: (context, snapshot){
          return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            controller: scrollController,
            itemBuilder: (context, index){
              DocumentSnapshot data = snapshot.data!.docs[index];
              return displayComplaintsMessages("${data['SentBy']}", "${data['Message']}", "${data['ProfileUrl']}");
            },
          )
              :
          Center(child: CircularProgressIndicator(),);

        }
    );
  }


  @override
  void initState() {
    getMessageDetails();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MCE Student Zone'),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              color: Colors.blueGrey,
              padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 65),
              child: getComplaintsMessages(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                color: Colors.blue,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Text",
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        addMessage(true);
                        messageController.text = "";
                        messageID = null;
                        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
