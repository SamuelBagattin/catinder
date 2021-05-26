import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';

Future<PickedFile> selectMedia() async {
  final picker = ImagePicker();
  return await picker.getImage(source: ImageSource.gallery);
}

bool validateFileFormat(String path, BuildContext context) {
  final m = mime(path);
  print(m);
  return true;
}

void showUploadMessage(BuildContext context, String s, {bool showLoading, int durationSeconds}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        CircularProgressIndicator(),
        Text(s),
      ],
    ),
    duration: Duration(seconds: durationSeconds != null ? durationSeconds : 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

UploadTask uploadData({String storagePath, String filename}) {
  Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child(filename);
  return firebaseStorageRef.putFile(File(storagePath));
}
