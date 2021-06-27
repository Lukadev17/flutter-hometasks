import 'package:fe_todo_app/data/database.dart';
import 'package:fe_todo_app/data/models/todo.dart';
import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _taskController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      color: Color(0xFF04a3a3),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                cursorColor: Colors.white,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                decoration: new InputDecoration(
                    hintText: "Please enter title",
                    hintStyle: TextStyle(
                      color: Color(0xFF6cb4b1),
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
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                decoration: new InputDecoration(
                    hintText: "Please enter task",
                    hintStyle: TextStyle(
                      color: Color(0xFF6cb4b1),
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
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                decoration: new InputDecoration(
                    hintText: "Please enter task details",
                    hintStyle: TextStyle(
                      color: Color(0xFF6cb4b1),
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
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                        Todo todo = Todo(
                          title: _titleController.text,
                          todoTask: _taskController.text,
                          todoDescription: _descriptionController.text,
                          isCompleted: false,
                        );
                        Database.addTodo(todo: todo);
                        Navigator.pop(context);
                      }
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
            )
          ],
        ),
      ),
    );
  }
}
