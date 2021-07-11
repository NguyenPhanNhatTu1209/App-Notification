import 'package:flutter/material.dart';
import 'package:todolist/src/screens/home_screen.dart';
import 'package:todolist/src/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            child: ListView(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/loading.gif',
                            image:
                                'https://scontent-sin6-4.xx.fbcdn.net/v/t1.15752-9/215782512_1171106806702316_5623792905438403312_n.png?_nc_cat=103&ccb=1-3&_nc_sid=ae9488&_nc_ohc=neFjkQiuBkIAX-4xKJh&_nc_ht=scontent-sin6-4.xx&oh=93ae785848ffb49f30bf4ad6c2a18188&oe=60EF1AD2',
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                          ),
                        )
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                        keyboardType: TextInputType
                            .emailAddress, // Use email input type for emails.
                        decoration: InputDecoration(
                            hintText: 'you@example.com',
                            labelText: 'E-mail Address',
                            icon: Icon(Icons.email)))),
                Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                      obscureText: true, // Use secure text for passwords.
                      decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Enter your password',
                          icon: Icon(Icons.lock))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 210.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0),
                      child: RaisedButton(
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => HomeScreen())),
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 50.0,
                  width: 210.0,
                  margin: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: RaisedButton(
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => RegistrationScreen())),
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
