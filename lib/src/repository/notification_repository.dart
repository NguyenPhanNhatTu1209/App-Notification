// title, body, urlToImage, date, isDeleted

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class NotificationRepository {
  addNotification({title, body, urlToImage, date}) async {
    FirebaseFirestore.instance.collection('notifications').add({
      'title': title,
      'body': body,
      'image': urlToImage,
      'date': date,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  editNotification({title, body, urlToImage, date, index}) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(index, {
        'title': title,
        'body': body,
        'image': urlToImage,
        'date': date,
      });
    });
  }

  deleteNotification(dynamic index) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.delete(index);
    });
  }
}
