import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class StoryAddPage extends StatefulWidget {
  final List<dynamic> storylist;
  final String city;
  final String userID;

  StoryAddPage(
    this.storylist,
    this.city,
    this.userID,
  );
  @override
  _StoryAddPageState createState() =>
      _StoryAddPageState(storylist, city, userID);
}

class _StoryAddPageState extends State<StoryAddPage> {
  List<dynamic> storyList;
  String city;
  String userID;
  _StoryAddPageState(this.storyList, this.city, this.userID);
  File image;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(84, 176, 243, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20.0),
              height: MediaQuery.of(context).size.width * 0.6,
              width: MediaQuery.of(context).size.width * 0.6,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: (image == null)
                      ? Center(child: Text("Choose an image"))
                      : PinchZoom(
                          maxScale: 4.0,
                          zoomedBackgroundColor: Colors.black.withOpacity(0.4),
                          resetDuration: Duration(microseconds: 100),
                          image: Image.file(
                            image,
                            fit: BoxFit.cover,
                          ),
                        )),
            ),
            Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * 0.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedButton(
                    color: Color.fromRGBO(84, 176, 243, 1),
                    enabled: true,
                    duration:
                        70, // Animaton duration, default is 70 Milliseconds
                    width: MediaQuery.of(context).size.width *
                        0.35, // Button Height, default is 64
                    height: MediaQuery.of(context).size.width * 0.1,
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      final storage = FirebaseStorage.instance;

                      var timestamp = DateTime.now();
                      if (image != null) {
                        await storage
                            .ref()
                            .child("Story/$city/$userID/${storyList.length}")
                            .putFile(image)
                            .whenComplete(() async {
                          print("Image Uploaded");
                        });

                        var img = await image.length();
                        print(img);
                        String imgURL = await storage
                            .ref()
                            .child("Story/$city/$userID/${storyList.length}")
                            .getDownloadURL();

                        setState(() {
                          storyList.add({
                            'url': imgURL,
                            'time': timestamp,
                          });
                        });

                        FirebaseFirestore.instance
                            .collection(city)
                            .doc(userID)
                            .update({'stories': storyList}).then((value) {
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  AnimatedButton(
                    color: Color.fromRGBO(84, 176, 243, 1),
                    enabled: true,
                    duration:
                        70, // Animaton duration, default is 70 Milliseconds
                    width: MediaQuery.of(context).size.width *
                        0.35, // Button Height, default is 64
                    height: MediaQuery.of(context).size.width * 0.1,
                    onPressed: () async {
                      final picker = ImagePicker();
                      PickedFile imageFile = await picker.getImage(
                        source: ImageSource.gallery,
                        imageQuality: 60,
                      );

                      int size = await File(imageFile.path).length();
                      print(size);

                      setState(() {
                        image = File(imageFile.path);
                      });
                    },
                    child: Text(
                      "CHOOSE",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            loading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
