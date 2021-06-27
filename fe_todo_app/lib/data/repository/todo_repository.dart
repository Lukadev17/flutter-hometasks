import 'package:fe_todo_app/data/models/todo.dart';
import 'package:flutter/material.dart';

import '../database.dart';

class TodoRepository extends ChangeNotifier {
  Todo currentTodo =
      Todo(title: "", todoTask: "", todoDescription: "", isCompleted: false);

  void showSelectedTodo(String? docId) async {
    await Database.readTodo(docId: docId).then((value) => {
          currentTodo.title = value.get("title"),
          currentTodo.todoTask = value.get("todoTask"),
          currentTodo.todoDescription = value.get("todoDescription"),
          currentTodo.isCompleted = value.get("isCompleted"),
          currentTodo.docId = value.id
        });
    notifyListeners();
  }

  void changeCurrentTodoStatus() {
    currentTodo.isCompleted = !currentTodo.isCompleted;
    notifyListeners();
  }
}
