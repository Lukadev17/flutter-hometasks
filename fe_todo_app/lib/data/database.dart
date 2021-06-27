import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/todo.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collectionReference = _firestore.collection('usersData');

class Database{
  static String? userId;

  static Future<void> addTodo({required Todo todo}) async {
    DocumentReference documentReference =
    _collectionReference.doc(userId).collection("todos").doc();

    var data = <String, dynamic>{
      "title": todo.title,
      "todoTask": todo.todoTask,
      "todoDescription": todo.todoDescription,
      "isCompleted": todo.isCompleted
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("user's todo added !"))
        .catchError((e) => print(e));
  }

  //read data as stream
  static Stream<QuerySnapshot> readTodos() {
    CollectionReference todosReference =
    _collectionReference.doc(userId).collection("todos");
    return todosReference.snapshots();
  }

  static Future<QuerySnapshot> readTodosAsList() async {
    CollectionReference expensesReference =
    _collectionReference.doc(userId).collection("todos");
    return expensesReference.get();
  }

  static Future<DocumentSnapshot> readTodo({required String? docId}) async {
    return await _collectionReference
        .doc(userId)
        .collection("todos")
        .doc(docId)
        .get();
  }

  static Future<void> updateTodo(
      {required String? docId, required Todo todo}) async {
    DocumentReference documentReference =
    _collectionReference.doc(userId).collection("todos").doc(docId);

    var data = <String, dynamic>{
      "title": todo.title,
      "todoTask": todo.todoTask,
      "todoDescription": todo.todoDescription
    };

    await documentReference
        .update(data)
        .whenComplete(() => print("todo updated!"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteTodo({required String? docId}) async {
    DocumentReference documentReference =
    _collectionReference.doc(userId).collection("todos").doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print("todo deleted!"))
        .catchError((e) => print(e));
  }

  static Future<void> changeTodoStatus(
      {required String? docId, required bool isCompleted}) async {
    DocumentReference documentReference =
    _collectionReference.doc(userId).collection("todos").doc(docId);

    var data = <String, dynamic>{
      "isCompleted": isCompleted,
    };

    await documentReference
        .update(data)
        .whenComplete(() => print("todo status changed!"))
        .catchError((e) => print(e));
  }
}