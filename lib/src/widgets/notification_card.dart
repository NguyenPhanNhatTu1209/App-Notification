import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/src/Controllers/todo_controller.dart';

class ToDoCart extends StatefulWidget {
  // ToDoCart({required this.todo});
  @override
  State<StatefulWidget> createState() {
    return _ToDoCart();
  }
}

class _ToDoCart extends State<ToDoCart> {
  ToDo? todo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TodoController todoController = TodoController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Colors.lightBlue[50],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue.shade200, width: 2)),
      padding: EdgeInsets.only(left: 24, right: 8),
      margin: EdgeInsets.only(top: 8),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.timer,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tập thể dục vào 4h chiều",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Lấy các bài tập trong app để tập thể dục ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Thời gian:",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image:
                  'https://edumedia.dalatcity.org//Images/LDG/tdhan/0/0/89/photo115426135354361264118870crop1542614479467611797574_637351550071495154.jpg',
              fit: BoxFit.fill,
              height: 150,
              width: 350,
            ),
          )
        ],
      ),
    );
  }
}
