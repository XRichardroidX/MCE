import 'dart:io';
import 'dart:typed_data';
import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_c_e/database/database.dart';
import 'package:m_c_e/screens/post/student_post_view_screen.dart';
import 'package:photo_view/photo_view.dart';
import 'package:random_string/random_string.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class AdminPostScreen extends StatefulWidget {
  const AdminPostScreen({Key? key}) : super(key: key);

  @override
  State<AdminPostScreen> createState() => _AdminPostScreenState();
}

class _AdminPostScreenState extends State<AdminPostScreen> {
  TextEditingController typingTextController = TextEditingController();
  TextEditingController imageTextController = TextEditingController();
  TextEditingController videoTextController = TextEditingController();
  VideoPlayerController? vidController;
  String? videoUrl;

  bool isTyping = false;
  bool onTap = false;
  var MyUserName;
  var ProfileUrl;

     // Get the current user UerID
  String UserID = FirebaseAuth.instance.currentUser!.uid;

     //Get the current User Name
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

     // Get the current User Profile picture URL
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

  //Todo This are the upload text to database section
  // This functions adds the username and profile URL function up together and initializes them in the init state function
  getMessageDetails() async {
    MyUserName = await getUserNameForTexting();
    ProfileUrl = await getUserProfileUrlForTexting();
  }

     //This Function gets the text posted on the Whats Up page in the app and stores it in the database file
  getTextPostToDatabase(String text) async {
    if(text != null){
      var MessageSentTime = await DateTime.now();
      if(ProfileUrl == null){
        ProfileUrl = "https://poly-ag.com/wp-content/uploads/2020/12/guest-user.jpg";
      }
      if(MyUserName == null){
        MyUserName = "Loading...";
      }
      String Img = "null";
      String imgText = "null";
      String Video = "null";
      String vidText = "null";
      Map<String, dynamic> TextPostDetails = await {
        "Message" : text,
        "SentBy" : MyUserName,
        "Time" : MessageSentTime,
        "ProfileUrl" : ProfileUrl,
        "Image" : Img,
        "imgText" : imgText,
        "Video" : Video,
        "vidText" : vidText,
      };

      String TextPostID = randomAlphaNumeric(19);

      Database().uplaodTextPostToDatabase(TextPostID, TextPostDetails);

    }
  }





  //Todo This are the upload image to database section
  //This Function gets the Image and text posted on the Whats Up page in the app and stores it in the database file
  getImagePostToDatabase(String image) async {
    if(image != null){
      var MessageSentTime = await DateTime.now();
      if(ProfileUrl == null){
        ProfileUrl = "https://poly-ag.com/wp-content/uploads/2020/12/guest-user.jpg";
      }
      if(MyUserName == null){
        MyUserName = "Loading...";
      }
      String Video = "null";
      String vidText = "null";
      String Message = "null";
      Map<String, dynamic> ImagePostDetails = await {
        "Image" : image,
        "imgText" : text,
        "SentBy" : MyUserName,
        "Time" : MessageSentTime,
        "ProfileUrl" : ProfileUrl,
        "Message" : Message,
        "Video" : Video,
        "vidText" : vidText,
      };

      String TextPostID = randomAlphaNumeric(19);

      Database().uplaodImagePostToDatabase(TextPostID, ImagePostDetails);

    }
  }

  @override
  Uint8List? _image;
  String? text;
  String? image;
  Future selectImage() async {
    await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("Write something about this image"),
        content: TextField(
          controller: imageTextController,
          autofocus: true,
          decoration: InputDecoration(hintText: "Type here"),
        ),
        actions: [
          TextButton(
            onPressed: (){
              text = imageTextController.text;
              imageTextController.text = "";
              Navigator.of(context).pop();
            },
            child: Text("Add text comment"),
          ),
        ],
      );
    });
    return showDialog(context: context, builder: (context){
      return SimpleDialog(
        title: const Text("Post an Image"),
        children: [
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Take a photo"),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await Database().pickImage(ImageSource.camera);
              setState(() async {
                _image = file;

                // Storing the image file in the Firebase Storage and returning the Url String, which I'm storing in a variable called image
                image = await Database().ConvertImageToStringAndDeployToStorage(_image!);

        // take the Image and Text comment to the getImagePostToDatabase to take to the Database file Class
                await getImagePostToDatabase(image!);

              });
            },
          ),
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Choose from gallery"),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await Database().pickImage(ImageSource.gallery,);
              setState(() async {
                _image = file;

                // Storing the image file in the Firebase Storage and returning the Url String, which I'm storing in a variable called image
                image = await Database().ConvertImageToStringAndDeployToStorage(_image!);

                // take the Image and Text comment to the getImagePostToDatabase to take to the Database file Class
                await getImagePostToDatabase(image!);
              });

            },
          ),
        ],
      );
    });
  }






//Todo This are the upload video to database section
  Future selectFile() async {
    File? file;
    String? vidTextController;
    showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("Write something about this video"),
        content: TextField(
          controller: videoTextController,
          autofocus: true,
          decoration: InputDecoration(hintText: "Type here"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              vidTextController = videoTextController.text;
              Navigator.of(context).pop();
            },
            child: Text("Add text comment"),
          ),
        ],
      );
    });

    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if(result == null)return;

    final path = result.files.single.path!;

    file = File(path);
    String _video = await Database().uploadFile(file) as String;
    getVideoPostToDatabase(_video, vidTextController!);
    _video = "";
    videoTextController.text = "";
  }

  //This Function gets the Videos and text posted on the Whats Up page in the app and stores it in the database file
  getVideoPostToDatabase(String video, String _vidTextController) async {

    if(video != null && _vidTextController != null){
      var MessageSentTime = await DateTime.now();
      if(ProfileUrl == null){
        ProfileUrl = "https://poly-ag.com/wp-content/uploads/2020/12/guest-user.jpg";
      }
      if(MyUserName == null){
        MyUserName = "Loading...";
      }
      String Message = "null";
      String imgText = "null";
      String Image = "null";
      Map<String, dynamic> videoPostDetails = await {
        "Video" : video,
        "vidText" : _vidTextController,
        "SentBy" : MyUserName,
        "Time" : MessageSentTime,
        "ProfileUrl" : ProfileUrl,
        "Message" : Message,
        "Image" : Image,
        "imgText" : imgText,
      };
      String TextPostID = randomAlphaNumeric(19);
      Database().uplaodVideoPostToDatabase(TextPostID, videoPostDetails);

    }
  }




      //Todo This is a Stream Builder function that collects the real time data from the data base and sends it to the displayWhat'sUp function
  Widget getWhatsUpUpdate() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("What'sUp").orderBy('Time', descending: true).snapshots(),
        builder: (context, snapshot){
          return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
              DocumentSnapshot data = snapshot.data!.docs[index];
              return displayWhatsUp(SentBy: "${data['SentBy']}", ProfileUrl: "${data['ProfileUrl']}", Message: "${data['Message']}", Image: "${data['Image']}", imgText: "${data['imgText']}", Video: "${data['Video']}", vidText: "${data['vidText']}");
            },
          )
              :
          Center(child: CircularProgressIndicator(),);

        }
    );
  }



          //Todo This Function displays the Video / Images / Text Message sent to the platform by the administration
  displayWhatsUp({required String SentBy, required String ProfileUrl, required String Message, required String Image, required String imgText, required String Video, required String vidText}){
    //If there is a Text Message then display the Text Message
    if(Message != null && Image == "null" && imgText == "null" && Video == "null" && vidText == "null"){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        margin: EdgeInsets.symmetric(vertical: 17.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.0),
          color: Colors.grey,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                    NetworkImage(ProfileUrl),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(width: 20,),
                  Text(
                    "$SentBy",
                    style: GoogleFonts.kanit(color: Colors.white, fontSize: 17,),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "$Message",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
    //If there is a Image then display the Image with it's imgText
    if(Message == "null" && Image != null && imgText != null && Video == "null" && vidText == "null"){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 17.0),
        margin: EdgeInsets.symmetric(vertical: 17.0),
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                    NetworkImage(ProfileUrl),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(width: 20,),
                  Text(
                    "$SentBy",
                    style: GoogleFonts.kanit(color: Colors.white, fontSize: 17,),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
              ),
              child: Text(
                "$imgText",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            onTap
                ?
            InkWell(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: PhotoView(
                      imageProvider: NetworkImage("$Image"),
                    )
                ),
                onTap: () {
                  setState(() {
                    onTap = false;
                  });
                }
            )
                :
            InkWell(
              onTap: () {
                setState(() {
                  onTap = true;
                });
              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "$Image",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    //If there is a video then display the video with it's vidText
    if(Message == "null" && Image == "null" && imgText == "null" && Video != null && vidText != null){
      videoUrl = Video;
      return Container(
        padding: EdgeInsets.symmetric(vertical: 17.0),
        margin: EdgeInsets.symmetric(vertical: 17.0),
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: vidController!.value.isInitialized
            ?
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                    NetworkImage(ProfileUrl),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(width: 20,),
                  Text(
                    "$SentBy",
                    style: GoogleFonts.kanit(color: Colors.white, fontSize: 17,),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                "$SentBy",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: vidController!.value.aspectRatio,
              child: VideoPlayer(vidController!),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: (){
                    Duration currentPosition = vidController!.value.position;
                    Duration targetPosition = currentPosition - const Duration(seconds: 10);
                    vidController!.seekTo(targetPosition);
                  },
                  icon: Icon(Icons.skip_previous),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: (){
                    setState(() {
                      vidController!.value.isPlaying
                          ?
                      vidController!.pause()
                          :
                      vidController!.play();
                    });
                  },
                  icon: Icon(vidController!.value.isPlaying ? Icons.pause : Icons.play_arrow,),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: (){
                    setState(() {
                      Duration currentPosition = vidController!.value.position;
                      Duration targetPosition = currentPosition + const Duration(seconds: 10);
                      vidController!.seekTo(targetPosition);
                    });
                  },
                  icon: Icon(Icons.fast_forward),
                  color: Colors.white,
                ),
              ],
            )
          ],
        )
            :
        Container(
          child: Center(
            //child: Text("",style: GoogleFonts.lobster(color: Colors.lightBlue),),
          ),
        ),
      );
    }
  }









// TODO: implement initState
  @override
  void initState() {
    super.initState();
    getMessageDetails();
    vidController = VideoPlayerController.network("https://www.vecteezy.com/free-videos/mp4")..initialize().then((_){
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    vidController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("MCE Notification Feeds", style: GoogleFonts.kanit(fontSize: 24),)),
        elevation: 0.0,
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(0.0, 68.0, .0, 0.0),
                child: getWhatsUpUpdate(),
            ),
            Container(
                  alignment: Alignment.topCenter,
                  child: isTyping
                  ?
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          isTyping = false;
                          setState(() {typingTextController.text = "";});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
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
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                isTyping = true;
                              });
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: typingTextController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Communicate with the MCE community with a post",
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.post_add),
                                  onPressed: (){
                                    setState(() {
                                      getTextPostToDatabase(typingTextController.text);
                                      isTyping = false;
                                      typingTextController.text = "";
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  :
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            selectImage();
                          },
                          icon: Icon(Icons.camera),
                      ),
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
                                child: Focus(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Communicate with the MCE community with a post",
                                    ),
                                  ),
                                  onFocusChange: (hasFocus) {
                                    if(hasFocus) {
                                      setState(() {
                                        isTyping = true;
                                      });
                                    }
                                  },
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          selectFile();
                        },
                        icon: Icon(Icons.videocam),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton
        (
        child: Icon(Icons.download),
        onPressed: ()
        {
          vidController = VideoPlayerController.network(videoUrl!)..initialize().then((_){
            setState(() {});
          });
        },
      ),
    );
  }
}











