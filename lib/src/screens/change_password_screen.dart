import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/src/screens/home_screen.dart';
import 'package:todolist/src/screens/login_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => new _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _passwordOldController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _retypePswController = TextEditingController();
  String? passwordNew;
  String? passwordOld;

  tapChangePasswordButton() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
          ),
        ),
        barrierColor: Colors.grey.shade100,
        barrierDismissible: false,
      );
      final _auth = FirebaseAuth.instance.currentUser;
      var email = _auth!.email.toString();
      print('EmailTu ' + email);
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: passwordOld!,
        );

        _auth.updatePassword(passwordNew!).then((_) {
          print("Successfully changed password");
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        }).catchError((error) {
          print("Password can't be changed" + error.toString());
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChangePasswordScreen(),
            ),
          );
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChangePasswordScreen(),
            ),
          );
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChangePasswordScreen(),
            ),
          );
        }
      }
      // var user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: email,
      //   password: passwordOld!,
      // );
      // print('Tu ' + user.user!.uid.toString());
      // if (user != null) {
      //   _auth.updatePassword(passwordNew!);
      //   Navigator.pop(context);
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => LoginScreen(),
      //     ),
      //   );
      // } else {
      //   Navigator.pop(context);
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => ChangePasswordScreen(),
      //     ),
      //   );
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
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
                                'https://truyenvn.com/tin/wp-content/uploads/2020/11/trai-ac-quy-cua-luffy-1.jpg',
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
                    controller: _passwordOldController,
                    validator: (val) => val!.trim().length < 6
                        ? 'Mật khẩu phải có tối thiểu 6 kí tự'
                        : null,
                    onChanged: (val) {
                      passwordOld = val.trim();
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password Old',
                      labelText: 'Enter your password old',
                      icon: Icon(Icons.lock),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    controller: _passwordController,
                    validator: (val) => val!.trim().length < 6
                        ? 'Mật khẩu phải có tối thiểu 6 kí tự'
                        : null,
                    onChanged: (val) {
                      passwordNew = val.trim();
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password New',
                      labelText: 'Enter your password new',
                      icon: Icon(Icons.lock),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    controller: _retypePswController,
                    validator: (val) => val!.trim() != passwordNew
                        ? 'Mật khẩu không trùng khớp'
                        : null,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      labelText: 'Enter your confirm password',
                      icon: Icon(Icons.lock),
                    ),
                  ),
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
                          'Change Password',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => tapChangePasswordButton(),
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
