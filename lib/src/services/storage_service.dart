import 'dart:io';

// Notifications/File
// User/Avatar

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  Future<String> uploadImageToStorage(File file) async {
    String fileName =
        DateTime.now().toString() + FirebaseAuth.instance.currentUser!.uid;
    Reference storageRef =
        FirebaseStorage.instance.ref().child('Notifications').child(fileName);
    UploadTask uploadTask = storageRef.putFile(file);
    var url = await uploadTask.snapshot.ref.getDownloadURL();
    return url;
  }
}
