import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/src/Controllers/todo_controller.dart';
import 'package:todolist/src/screens/create_notification_screen.dart';
import 'package:todolist/src/screens/edit_notification_screen.dart';
import 'package:todolist/src/widgets/notification_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  TodoController todoController = TodoController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoController.getToDo();
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
        // actions: [
        //   IconButton(
        //       onPressed: () => Navigator.of(context).push(
        //           MaterialPageRoute(builder: (context) => HistoryScreen())),
        //       icon: Icon(
        //         Icons.list,
        //         color: Colors.white,
        //         size: 30.0,
        //       ))
        // ],
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
