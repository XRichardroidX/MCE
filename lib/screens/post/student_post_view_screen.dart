import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StudentPostViewScreen extends StatefulWidget {
  const StudentPostViewScreen({Key? key}) : super(key: key);

  @override
  State<StudentPostViewScreen> createState() => _StudentPostViewScreenState();
}

class _StudentPostViewScreenState extends State<StudentPostViewScreen> {
  VideoPlayerController? vidController;
  String? videoUrl;


  //Todo THis is a Stream Builder function that collects the real time data from the data base and sends it to the displayWhat'sUp function
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
      return Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(17.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey,
          ),
          child: Text(
            "$Message",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    //If there is a Image then display the Image with it's imgText
    if(Message == "null" && Image != null && imgText != null && Video == "null" && vidText == "null"){
      return Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(17.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "$imgText",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      "$Image",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    //If there is a video then display the video with it's vidText
    if(Message == "null" && Image == "null" && imgText == "null" && Video != null && vidText != null){
      videoUrl = Video;
      return Center(
        child: vidController!.value.isInitialized
            ?
        Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(17.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "$vidText",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
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
          ),
        )
            :
        Container(
          child: Center(child: CircularProgressIndicator(),),
        ),
      );
    }
  }

// TODO: implement initState
  @override
  void initState() {
    super.initState();
    vidController = VideoPlayerController.network("https://www.vecteezy.com/free-videos/mp4")..initialize().then((_){
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("MCE Notification feeds")),
        elevation: 0.0,
      ),
      body: Container(
        child: Stack(
          children: [
            getWhatsUpUpdate(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton
        (
        child: Text(
          "Click to\ncheck for\nVideo\nupdates!",
          style: TextStyle(
            fontSize: 7.0,
          ),
        ),
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











