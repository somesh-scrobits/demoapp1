import 'dart:io';

import 'package:demoapp/home/view/videodetails.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomePageController extends GetxController {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  var image;
  String filename = "";
  List? urls;

  Future<void> selectImage() async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
      maxHeight: 400,
      maxWidth: 400,
    );
    image = File(imageFile!.path);
    filename = basename(imageFile.path);
    update();
    Get.back();
    // Get.testMode = true;
    // Get.to(() => VideoDetails());
  }

  Future<void> uploadImage() async {
    Reference reference = firebaseStorage.ref().child('images/${filename}');
    UploadTask uploadTask = reference.putFile(image);
    uploadTask.then((res) {
      res.ref.getDownloadURL();
    });
  }

  getImage() {
    Reference reference = firebaseStorage.ref().child('images');
   // urls = reference.getData();
   //reference.child().
  }
}
