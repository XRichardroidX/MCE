import 'dart:typed_data';
import 'package:auth/auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'dart:io';
import '../auth/show_snack_bar.dart';
import '../screens/athentication_screens/welcome.dart';


class Database {


  addComplaintsToDatabase(String MessageID,
      Map<String, dynamic> MessageDetails) async {
    await FirebaseFirestore.instance
        .collection("ComplaintsMessageRoom")
        .doc(MessageID)
        .set(MessageDetails);
  }

  addMessagesToDatabase(String MessageID,
      Map<String, dynamic> MessageDetails) async {
    await FirebaseFirestore.instance
        .collection("AdminChatRoom")
        .doc(MessageID)
        .set(MessageDetails);
  }


  addStudentChatToDatabase(String MessageID,
      Map<String, dynamic> MessageDetails) async {
    await FirebaseFirestore.instance
        .collection("StudentChatRoom")
        .doc(MessageID)
        .set(MessageDetails);
  }

  uplaodTextPostToDatabase(String TextPostID,
      Map<String, dynamic> TextPostDetails) async {
    await FirebaseFirestore.instance
        .collection("What'sUp")
        .doc(TextPostID)
        .set(TextPostDetails);
  }

  uplaodImagePostToDatabase(String TextPostID,
      Map<String, dynamic> ImagePostDetails) async {
    await FirebaseFirestore.instance
        .collection("What'sUp")
        .doc(TextPostID)
        .set(ImagePostDetails);
  }

  uplaodVideoPostToDatabase(String TextPostID,
      Map<String, dynamic> VideoPostDetails) async {
    await FirebaseFirestore.instance
        .collection("What'sUp")
        .doc("VidioID")
        .set(VideoPostDetails);
  }


// Search for Students with their Registration Number
  Future<Stream<QuerySnapshot>> getUserByRegNumber(String regNumber) async {
    return FirebaseFirestore.instance.collection("Users").where(
        "Reg-Number", isEqualTo: regNumber).snapshots();
  }


  //This is a function to pick an image from your Gallery or Camera on your Android Device.
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
  }

  //Todo 100 Level 1st First Semester
  Future MTH101(BuildContext context, String UserID,
      TextEditingController StudentResult) async {
    return await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("MTH 101 Result"),
        content: TextField(
          controller: StudentResult,
          autofocus: true,
          decoration: InputDecoration(hintText: "Example: 90%   A"),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("Users")
                    .doc(UserID)
                    .update(
                    {
                      "MTH101": StudentResult.text,
                    }
                );
                Navigator.of(context).pop();
              },
              child: Text('SUBMIT')
          ),
        ],
      );
    });
  }

  Future PHY101(BuildContext context, String UserID,
      TextEditingController StudentResult) async {
    print(StudentResult);
    return await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("PHY 101 Result"),
        content: TextField(
          controller: StudentResult,
          autofocus: true,
          decoration: InputDecoration(hintText: "Example: 90%   A"),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("Users")
                    .doc(UserID)
                    .update(
                  {
                    "PHY101": StudentResult.text,
                  },
                );
                Navigator.of(context).pop();
              },
              child: Text('SUBMIT')
          ),
        ],
      );
    });
  }

  Future CHM101(BuildContext context, String UserID,
      TextEditingController StudentResult) async {
    return await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("CHM 101 Result"),
        content: TextField(
          controller: StudentResult,
          autofocus: true,
          decoration: InputDecoration(hintText: "Example: 90%   A"),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("Users")
                    .doc(UserID)
                    .update(
                    {
                      "CHM101": StudentResult.text,
                    }
                );
                Navigator.of(context).pop();
              },
              child: Text('SUBMIT')
          ),
        ],
      );
    });
  }

  Future BIO101(BuildContext context, String UserID,
      TextEditingController StudentResult) async {
    return await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("BIO 101 Result"),
        content: TextField(
          controller: StudentResult,
          autofocus: true,
          decoration: InputDecoration(hintText: "Example: 90%   A"),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("Users")
                    .doc(UserID)
                    .update(
                    {
                      "BIO101": StudentResult.text,
                    }
                );
                Navigator.of(context).pop();
              },
              child: Text('SUBMIT')
          ),
        ],
      );
    });
  }

  Future ENG101(BuildContext context, String UserID,
      TextEditingController StudentResult) async {
    return await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("ENG 101 Result"),
        content: TextField(
          controller: StudentResult,
          autofocus: true,
          decoration: InputDecoration(hintText: "Example: 90%   A"),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("Users")
                    .doc(UserID)
                    .update(
                    {
                      "ENG101": StudentResult.text,
                    }
                );
                Navigator.of(context).pop();
              },
              child: Text('SUBMIT')
          ),
        ],
      );
    });
  }

  Future ENG103(BuildContext context, String UserID,
      TextEditingController StudentResult) async {
    return await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("ENG 103 Result"),
        content: TextField(
          controller: StudentResult,
          autofocus: true,
          decoration: InputDecoration(hintText: "Example: 90%   A"),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("Users")
                    .doc(UserID)
                    .update(
                    {
                      "ENG103": StudentResult.text,
                    }
                );
                Navigator.of(context).pop();
              },
              child: Text('SUBMIT')
          ),
        ],
      );
    });
  }

  Future GST101(BuildContext context, String UserID,
      TextEditingController StudentResult) async {
    return await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("GST 101 Result"),
        content: TextField(
          controller: StudentResult,
          autofocus: true,
          decoration: InputDecoration(hintText: "Example: 90%   A"),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("Users")
                    .doc(UserID)
                    .update(
                    {
                      "GST101": StudentResult.text,
                    }
                );
                Navigator.of(context).pop();
              },
              child: Text('SUBMIT')
          ),
        ],
      );
    });
  }

  Future GST103(BuildContext context, String UserID,
      TextEditingController StudentResult) async {
    return await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("GST 103 Result"),
        content: TextField(
          controller: StudentResult,
          autofocus: true,
          decoration: InputDecoration(hintText: "Example: 90%   A"),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("Users")
                    .doc(UserID)
                    .update(
                    {
                      "GST103": StudentResult.text,
                    }
                );
                Navigator.of(context).pop();
              },
              child: Text('SUBMIT')
          ),
        ],
      );
    });
  }

  Future FRNIGB101(BuildContext context, String UserID,
      TextEditingController StudentResult) async {
    return await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("FRN 101/ IGB 101 Result"),
        content: TextField(
          controller: StudentResult,
          autofocus: true,
          decoration: InputDecoration(hintText: "Example: 90%   A"),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("Users")
                    .doc(UserID)
                    .update(
                    {
                      "FRNIGB101": StudentResult.text,
                    }
                );
                Navigator.of(context).pop();
              },
              child: Text('SUBMIT')
          ),
        ],
      );
    });
  }


  //Todo 100Level 2nd Second Semester

  Future MTH102(BuildContext context, String UserID,
      TextEditingController StudentResult) async {
    print(StudentResult);
    return await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("MTH 102 Result"),
        content: TextField(
          controller: StudentResult,
          autofocus: true,
          decoration: InputDecoration(hintText: "Example: 90%   A"),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("Users")
                    .doc(UserID)
                    .update(
                    {
                      "MTH102": StudentResult.text,
                    }
                );
                Navigator.of(context).pop();
              },
              child: Text('SUBMIT')
          ),
        ],
      );
    });
  }

  Future PHY102(BuildContext context, String UserID,
      TextEditingController StudentResult) async {
    print(StudentResult);
    return await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("PHY 102 Result"),
        content: TextField(
          controller: StudentResult,
          autofocus: true,
          decoration: InputDecoration(hintText: "Example: 90%   A"),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("Users")
                    .doc(UserID)
                    .update(
                  {
                    "PHY102": StudentResult.text,
                  },
                );
                Navigator.of(context).pop();
              },
              child: Text('SUBMIT')
          ),
        ],
      );
    });
  }

  Future CHM102(BuildContext context, String UserID,
      TextEditingController StudentResult) async {
    return await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("CHM 102 Result"),
        content: TextField(
          controller: StudentResult,
          autofocus: true,
          decoration: InputDecoration(hintText: "Example: 90%   A"),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("Users")
                    .doc(UserID)
                    .update(
                    {
                      "CHM102": StudentResult.text,
                    }
                );
                Navigator.of(context).pop();
              },
              child: Text('SUBMIT')
          ),
        ],
      );
    });
  }

  Future ENG102(BuildContext context, String UserID,
      TextEditingController StudentResult) async {
    return await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("ENG 102 Result"),
        content: TextField(
          controller: StudentResult,
          autofocus: true,
          decoration: InputDecoration(hintText: "Example: 90%   A"),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("Users")
                    .doc(UserID)
                    .update(
                    {
                      "ENG102": StudentResult.text,
                    }
                );
                Navigator.of(context).pop();
              },
              child: Text('SUBMIT')
          ),
        ],
      );
    });
  }

  Future ENG104(BuildContext context, String UserID,
      TextEditingController StudentResult) async {
    return await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("ENG 104 Result"),
        content: TextField(
          controller: StudentResult,
          autofocus: true,
          decoration: InputDecoration(hintText: "Example: 90%   A"),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("Users")
                    .doc(UserID)
                    .update(
                    {
                      "ENG104": StudentResult.text,
                    }
                );
                Navigator.of(context).pop();
              },
              child: Text('SUBMIT')
          ),
        ],
      );
    });
  }

  Future GST102(BuildContext context, String UserID,
      TextEditingController StudentResult) async {
    return await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("GST 102 Result"),
        content: TextField(
          controller: StudentResult,
          autofocus: true,
          decoration: InputDecoration(hintText: "Example: 90%   A"),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("Users")
                    .doc(UserID)
                    .update(
                    {
                      "GST102": StudentResult.text,
                    }
                );
                Navigator.of(context).pop();
              },
              child: Text('SUBMIT')
          ),
        ],
      );
    });
  }

  Future GST108(BuildContext context, String UserID,
      TextEditingController StudentResult) async {
    return await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("GST 108 Result"),
        content: TextField(
          controller: StudentResult,
          autofocus: true,
          decoration: InputDecoration(hintText: "Example: 90%   A"),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("Users")
                    .doc(UserID)
                    .update(
                    {
                      "GST108": StudentResult.text,
                    }
                );
                Navigator.of(context).pop();
              },
              child: Text('SUBMIT')
          ),
        ],
      );
    });
  }

  Future GST110(BuildContext context, String UserID,
      TextEditingController StudentResult) async {
    return await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("GST 110 Result"),
        content: TextField(
          controller: StudentResult,
          autofocus: true,
          decoration: InputDecoration(hintText: "Example: 90%   A"),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("Users")
                    .doc(UserID)
                    .update(
                    {
                      "GST110": StudentResult.text,
                    }
                );
                Navigator.of(context).pop();
              },
              child: Text('SUBMIT')
          ),
        ],
      );
    });
  }

  Future FRNIGB102(BuildContext context, String UserID,
      TextEditingController StudentResult) async {
    return await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        title: Text("FRN 102/ IGB 102 Result"),
        content: TextField(
          controller: StudentResult,
          autofocus: true,
          decoration: InputDecoration(hintText: "Example: 90%   A"),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection("Users")
                    .doc(UserID)
                    .update(
                    {
                      "FRNIGB102": StudentResult.text,
                    }
                );
                Navigator.of(context).pop();
              },
              child: Text('SUBMIT')
          ),
        ],
      );
    });
  }


  Future<String> uploadFile(file) async {
    String filePostID = randomAlphaNumeric(5);
    final fileName = File(file!.path);
    final destination = "VideoFiles/video";

    return await uploadFilesToFirebaseStorage(destination, fileName);
  }


  uploadFilesToFirebaseStorage(String destination, File file) async {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      UploadTask uploadTask = ref.putFile(file);

      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      return downloadUrl;
    }
    on FirebaseException catch (error) {
      return null;
    }
  }


  // This FUnction stores the image posted in firestore and returns the URL as a String to be stored in Firebase CloudFirestore
  Future<String> ConvertImageToStringAndDeployToStorage(
      Uint8List _file,) async {
    String imagePostID = randomAlphaNumeric(5);
    Reference ref = FirebaseStorage.instance.ref().child("Images").child(
        "${FirebaseAuth.instance.currentUser!.uid + imagePostID}");

    UploadTask uploadTask = ref.putData(_file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}