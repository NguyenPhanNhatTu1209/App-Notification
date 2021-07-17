import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/src/screens/home_screen.dart';
import 'package:todolist/src/screens/login_screen.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  final _auth = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Tu: " + _auth.toString());
    return _auth == null ? LoginScreen() : HomeScreen();
  }
}


// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     final _auth = FirebaseAuth.instance.currentUser;
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: _auth == null ? LoginScreen() : HomeScreen(),
//     );
//   }
// }
