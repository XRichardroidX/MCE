import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter/material.dart';
import 'package:m_c_e/database/database.dart';

class ComplaintBox extends StatefulWidget {

  @override
  State<ComplaintBox> createState() => _ComplaintBoxState();
}

class _ComplaintBoxState extends State<ComplaintBox> {
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

    if (messageController.text != null){

      String _messageController = messageController.text;
      var MessageSentTime = await DateTime.now();

          Map<String, dynamic> messageData = await {
            "Message": _messageController,
            "SentBy": MyUserName,
            "Time": MessageSentTime,
            "ProfileUrl": ProfileUrl,
          };

        messageID = randomAlphaNumeric(19);

      await Database().addComplaintsToDatabase(messageID!, messageData);

      if(sendClicked){
        messageController.text = "";
        messageID = "";
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
                color: Colors.black45,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      "https://poly-ag.com/wp-content/uploads/2020/12/guest-user.jpg",
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
                            "Anonymous",
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
                                color: Colors.white,
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      "https://poly-ag.com/wp-content/uploads/2020/12/guest-user.jpg",
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
                          Text("Anonymous"),
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
      stream: FirebaseFirestore.instance.collection('ComplaintsMessageRoom').orderBy('Time').snapshots(),
        builder: (context, snapshot){
          return snapshot.hasData && !snapshot.hasError ? ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            controller: scrollController,
            itemBuilder: (context, index){
              DocumentSnapshot ds = snapshot.data!.docs[index];
              return displayComplaintsMessages("${ds['SentBy']}", "${ds['Message']}", "${ds['ProfileUrl']}");
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
        title: Text('Complaint Box'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              color: Colors.brown,
              padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 65),
              child: getComplaintsMessages(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                color: Colors.blueGrey,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                      style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Your messages will be anonymous",
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        addMessage(true);
                        messageController.text = "";
                        messageID = "";
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
