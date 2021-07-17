// title, body, urlToImage, date, isDeleted

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationRepository {
  addNotification({title, body, urlToImage, date}) async {
    FirebaseFirestore.instance.collection('notifications').add({
      'title': title,
      'body': body,
      'image': urlToImage,
      'date': date,
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
