import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/src/screens/home_screen.dart';
import 'package:todolist/src/screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => new _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _retypePswController = TextEditingController();
  String? email;
  String? password;

  tapRegisterButton() async {
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
      var user = await _auth.createUserWithEmailAndPassword(
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
                    controller: _emailController,
                    validator: (val) => val!.trim().length == 0
                        ? 'Nhập email mới đc đăng kí'
                        : null,
                    onChanged: (val) {
                      setState(() {
                        email = val.trim();
                      });
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'you@example.com',
                      labelText: 'E-mail Address',
                      icon: Icon(Icons.email),
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
                      password = val.trim();
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Enter your password',
                      icon: Icon(Icons.lock),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    controller: _retypePswController,
                    validator: (val) =>
                        val!.trim() != password // UOC GI MAI DC AN KFC
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
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => tapRegisterButton(),
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
