import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';

class ToDoCartHistory extends StatefulWidget {
  final data;
  final index;
  ToDoCartHistory({required this.data, required this.index});
  @override
  State<StatefulWidget> createState() {
    return _ToDoCartHistory();
  }
}

class _ToDoCartHistory extends State<ToDoCartHistory> {
  ToDo? todo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todo = ToDo.fromFirestore(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Colors.lightBlue[50],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue.shade200, width: 2)),
      padding: EdgeInsets.only(left: 24, right: 8),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.timer,
              color: Colors.blue,
              size: 25,
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo!.title,
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  todo!.subTitle,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
