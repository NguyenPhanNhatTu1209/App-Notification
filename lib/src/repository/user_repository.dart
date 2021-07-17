import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  addTokenToUser(String fcmToken) async {
    QuerySnapshot<dynamic> snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (snapshot.docs.length == 0) {
      FirebaseFirestore.instance.collection('users').add({
        'email': FirebaseAuth.instance.currentUser!.email,
        'urlToImage': '',
        'fcmToken': fcmToken,
        'uid': FirebaseAuth.instance.currentUser!.uid,
      });
    } else {
      snapshot.docs[0].reference.update({
        'fcmToken': fcmToken,
      });
    }
  }
}
