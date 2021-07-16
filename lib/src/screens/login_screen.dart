import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/src/Controllers/Authentication.dart';
import 'package:todolist/src/screens/home_screen.dart';
import 'package:todolist/src/screens/registration_screen.dart';
import 'package:todolist/src/screens/reset_password_screen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? email;
  String? password;
  bool _isSigningIn = false;

  tapLoginButton() async {
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
      final _auth = FirebaseAuth.instance;
      var user = await _auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      print('lambiengcode ' + user.user!.uid.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: _isSigningIn
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : ListView(
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
                              controller: _emailController,
                              validator: (val) => val!.trim().length == 0
                                  ? 'Nhập email mới đc đăng kí'
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  email = val.trim();
                                });
                              },
                              keyboardType: TextInputType
                                  .emailAddress, // Use email input type for emails.
                              decoration: InputDecoration(
                                  hintText: 'you@example.com',
                                  labelText: 'E-mail Address',
                                  icon: Icon(Icons.email)))),
                      Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                            controller: _passwordController,
                            validator: (val) => val!.trim().length < 6
                                ? 'Mật khẩu phải có tối thiểu 6 kí tự'
                                : null,
                            onChanged: (val) {
                              password = val.trim();
                            },
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
                                horizontal: 50.0, vertical: 5.0),
                            child: RaisedButton(
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () => tapLoginButton(),
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                      Container(
                          height: 50.0,
                          width: 210.0,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 5.0),
                          child: SignInButton(
                            Buttons.Facebook,
                            text: "Sign in with FaceBook",
                            onPressed: () async {
                              User? user =
                                  await Authentication.loginWithFacebook(
                                      context: context);
                              if (user != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              }
                            },
                          )),
                      Container(
                          height: 50.0,
                          width: 210.0,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 5.0),
                          child: SignInButton(
                            Buttons.Google,
                            text: "Sign in with Google",
                            onPressed: () async {
                              setState(() {
                                _isSigningIn = true;
                              });
                              User? user =
                                  await Authentication.signInWithGoogle(
                                      context: context);
                              setState(() {
                                _isSigningIn = false;
                              });
                              if (user != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              }
                            },
                          )),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            child: Text('Forgot Password?'),
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ResetScreen()),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
          )),
    );
  }
}
