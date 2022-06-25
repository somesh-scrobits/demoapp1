import 'dart:io';

import 'package:demoapp/home/view/homepage.dart';
import 'package:demoapp/home/view/list_pro.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart';
//import 'package:image_editor_dove/image_editor.dart';
import 'package:image_editor_dove/flutter_image_editor.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePageController extends GetxController {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('posts');

  var image;
  var image2;
  String filename = "";

  String title ="null";
  String desc = "null";
  String photo_url = "";

  addData() {
    debugPrint(title + desc + photo_url);
    collectionReference.add(
        {'title': title, 'desc': desc, 'photo_url': photo_url}).then((value) {
      Fluttertoast.showToast(msg: "Saved");
    });
    Get.to(ListPro());
  }

  Future<void> toImageEditor(File origin, context) async {
    return Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ImageEditor(
        originImage: origin,
      );
    })).then((result) {
      if (result is EditorImageResult) {
        image = result.newFile;
       // image = copyCrop(image2, 00,300,300,400);
        update();
        Get.to(HomePage());
        // final croppedfile = ImageCropper().cropImage(
        //   uiSettings: buildUiSettings(context),
        //   sourcePath: image);
        // if (croppedfile != null) {
        //   image = croppedfile;
        //   update();
        //   Get.to(HomePage());
        // }

      }
    }).catchError((er) {
      debugPrint(er);
    });
  }

  Future<void> selectImage(context) async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      //imageQuality: 70,
      // maxHeight: 400,
      // maxWidth: 400,
    );
    if (imageFile != null) {
      File origin = File(imageFile.path);
      toImageEditor(origin, context);
    }
    //image = File(imageFile!.path);

    filename = basename(imageFile!.path);
    update();
    // Get.testMode = true;
    // Get.to(() => VideoDetails());
  }

  Future<void> uploadImage() async {
    Reference reference = firebaseStorage.ref().child('images/${filename}');
    UploadTask uploadTask = reference.putFile(image);
    uploadTask.then((res) async {
      photo_url = await res.ref.getDownloadURL();
      addData();
    });
  }

  // getImage() {
  //   Reference reference = firebaseStorage.ref().child('images/');
  //   reference.getDownloadURL().then(
  //     (value) {
  //       check = value.toString();
  //       debugPrint(value);
  //     },
  //   );
  //   debugPrint(check.toString());

  //   reference.listAll().then((value) => {
  //         urls = value.items,
  //         // debugPrint(value.items.toString()),
  //         // debugPrint(value.toString()),
  //         //Get.to(ListPro())
  //         debugPrint(check.toString())
  //       });
  //   // urls = reference.getData();
  //   //reference.child().
  // }
}
