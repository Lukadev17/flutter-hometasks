import 'package:fe_todo_app/data/database.dart';
import 'package:fe_todo_app/data/models/todo.dart';
import 'package:fe_todo_app/data/repository/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTodo extends StatefulWidget {
  const EditTodo({Key? key}) : super(key: key);

  @override
  _EditTodoState createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _taskController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    var currentTodo =
        Provider.of<TodoRepository>(context, listen: false).currentTodo;
    super.initState();
    _titleController = TextEditingController(text: currentTodo.title);
    _taskController = TextEditingController(text: currentTodo.todoTask);
    _descriptionController =
        TextEditingController(text: currentTodo.todoDescription);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _taskController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoRepository>(
      builder: (BuildContext context, todo, Widget? child) {
        return Container(
          padding: EdgeInsets.only(
            left: 32,
            right: 32,
          ),
          color: Color(0xFF04a3a3),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Colors.white,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: new InputDecoration(
                        hintText: "Please enter title",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please fulfill the field";
                      }
                      return null;
                    },
                    controller: _titleController,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Colors.white,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: new InputDecoration(
                        hintText: "Please enter task",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please fulfill the field";
                      }
                      return null;
                    },
                    controller: _taskController,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Colors.white,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: new InputDecoration(
                        hintText: "Please enter task details",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please fulfill the field";
                      }
                      return null;
                    },
                    controller: _descriptionController,
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 168,
                      height: 46,
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Todo newTodo = Todo(
                              title: _titleController.text,
                              todoTask: _taskController.text,
                              todoDescription: _descriptionController.text,
                              isCompleted: todo.currentTodo.isCompleted,
                            );
                            Database.updateTodo(
                                docId: todo.currentTodo.docId, todo: newTodo);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "EDIT",
                          style: TextStyle(
                              color: Color(0xFF04a3a3),
                            fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
