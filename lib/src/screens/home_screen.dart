import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/src/Controllers/todo_controller.dart';
import 'package:todolist/src/screens/change_password_screen.dart';
import 'package:todolist/src/screens/create_notification_screen.dart';
import 'package:todolist/src/screens/edit_notification_screen.dart';
import 'package:todolist/src/screens/login_screen.dart';
import 'package:todolist/src/widgets/notification_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  TodoController todoController = TodoController();

  Future<String?> getFCMToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  printToken() async {
    String? token = await getFCMToken();
    print(token.toString() + ' token ne');
  }

  handleFCM() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.notification!.title);
    });
  }

  @override
  void initState() {
    super.initState();
    printToken();
    handleFCM();
    todoController.getToDo();
  }

  Future<void> handleClick(String value) async {
    switch (value) {
      case 'ChangePass':
        print('ChangePass');
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
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChangePasswordScreen(),
          ),
        );
        break;
      case 'Logout':
        print('Logout');
        await FirebaseAuth.instance.signOut();
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
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CreateNotificationScreen())),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 20.0,
        ),
        backgroundColor: Colors.blueAccent,
      ),
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.list,
              color: Colors.white,
              size: 30.0,
            ),
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'ChangePass', 'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
          // IconButton(
          //     onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => ChangePasswordScreen())),
          //     icon: Icon(
          //       Icons.list,
          //       color: Colors.white,
          //       size: 30.0,
          //     )),
        ],
        title: Text(
          'Notifications',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Container(
          child: StreamBuilder(
              stream: todoController.getToDoStream,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  List<ToDo> data = snapshot.data;
                  return ListView.builder(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditNotificationScreen(
                                      // index: data[index],
                                      // title: data[index].title,
                                      // subTitle: data[index].subTitle,
                                      // time: DateTime.now(),
                                      // image: "",
                                      ))),
                          child: ToDoCart(),
                        );
                      });
                }
              })),
    );
  }
}
