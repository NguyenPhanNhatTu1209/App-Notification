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
  final _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    _user = _auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _user == null ? LoginScreen() : HomeScreen();
  }
}
