import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animated_button/animated_button.dart';

File image;

class PictureSelection extends StatefulWidget {
  final String sellerName;
  PictureSelection(this.sellerName);
  @override
  _PictureSelectionState createState() => _PictureSelectionState(sellerName);
}

class _PictureSelectionState extends State<PictureSelection> {
  final String sellerName;
  _PictureSelectionState(this.sellerName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(84, 176, 243, 1),
        title: Text(
          "Profile Picture Selector",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: (image == null)
                    ? Text("Choose and image")
                    : Image.file(
                        image,
                        height: MediaQuery.of(context).size.width * 0.8,
                        width: MediaQuery.of(context).size.width * 0.8,
                        fit: BoxFit.cover,
                      ),
              ),
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
                      final storage = FirebaseStorage.instance;
                      final CollectionReference collectionReference =
                          FirebaseFirestore.instance.collection('SellerData');
                      if (image != null) {
                        TaskSnapshot snapshot = await storage
                            .ref()
                            .child("SellerData/$sellerName")
                            .putFile(image)
                            .whenComplete(() async {
                          print("Image Uploaded");
                        });
                        String imgURL = await storage
                            .ref()
                            .child("SellerData/$sellerName")
                            .getDownloadURL();

                        collectionReference
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .update({
                          "PhotoURL": imgURL,
                        }).whenComplete(() {
                          print("Added to firebase storage");
                        });
                        Navigator.of(context).pop();
                      } else {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Please choose an image!")));
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
                      PickedFile imageFile =
                          await picker.getImage(source: ImageSource.gallery);
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
