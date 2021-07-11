import 'dart:async';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/src/repository/todo_repository.dart';

class TodoController {
  TodoRepository todoRepository = TodoRepository();
  StreamController<List<ToDo>> _todoListController =
      StreamController<List<ToDo>>();
  getToDo() async {
    List<ToDo> temp = [];
    var res = await todoRepository.getToDo();
    List<dynamic> listJson = convert.jsonDecode(res.body)['data'];
    listJson.forEach((element) {
      temp.add(ToDo.fromMap(element));
    });
    _todoListController.add(temp);
  }

  done(String idTodo) async {
    var body = {"_id": idTodo};
    var status = await todoRepository.doneToDo(body);
    print(idTodo);
    status == 200 ? print('Ok') : print('Fail');
    if (status == 200) {
      getToDo();
    }
  }

  delete(String idTodo) async {
    var status = await todoRepository.deleteToDo({
      "_id": idTodo,
    });
    status == 200 ? print('Ok') : print('Fail');
    if (status == 200) {
      getToDo();
    }
  }

  Stream<List<ToDo>> get getToDoStream => _todoListController.stream;
}
