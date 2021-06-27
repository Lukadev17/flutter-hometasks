import 'package:fe_todo_app/data/database.dart';
import 'package:fe_todo_app/data/repository/todo_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoRepository>(
      builder: (BuildContext context, todo, Widget? child) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 15, left: 10, right: 10),
            color: Color(0xFF04a3a3),
            child: Column(
              children: [
                Text(
                  todo.currentTodo.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  todo.currentTodo.todoTask,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "TODO DESCRIPTION",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "\t\t\t${todo.currentTodo.todoDescription}",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      decoration: BoxDecoration(
                        color: todo.currentTodo.isCompleted
                            ? Color(0xFF0ecc57)
                            : Color(0xFF6cb4b1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(
                        onPressed: () {
                          todo.changeCurrentTodoStatus();
                        },
                        child: Column(children: [
                          Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 38,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "DONE",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF6cb4b1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context, builder: (_) => EditTodo());
                        },
                        child: Column(children: [
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 38,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "EDIT",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ]),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF6cb4b1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text("Are you sure?"),
                                    content:
                                        Text("Do you really want to delete?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("No")),
                                      TextButton(
                                          onPressed: () {
                                            Database.deleteTodo(
                                                docId: todo.currentTodo.docId);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Yes")),
                                    ],
                                  ));
                        },

                        child: Column(children: [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 38,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "DELETE",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 168,
                        height: 42,
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Database.changeTodoStatus(
                                docId: todo.currentTodo.docId,
                                isCompleted: todo.currentTodo.isCompleted);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(
                                color: Color(0xFF04a3a3),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
