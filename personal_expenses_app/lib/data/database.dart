import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_expenses_app/data/models/expense.dart';

import 'models/expenseDTO.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collectionReference = _firestore.collection('users');

class Database {
  static String? userId;

  static Future<void> addExpense({required Expense expense}) async {
    DocumentReference documentReference =
        _collectionReference.doc(userId).collection('expenses').doc();
    var data = <String, dynamic>{
      "title": expense.title,
      "description": expense.description,
      "amount": expense.expenseAmount,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("user's expense added !"))
        .catchError((e) => print(e));
  }

  //read data as stream
  static Stream<QuerySnapshot> readStreamExpenses() {
    CollectionReference userNotesReference =
        _collectionReference.doc(userId).collection("expenses");
    return userNotesReference.snapshots();
  }

  static Future<QuerySnapshot> readExpenses() async {
    CollectionReference expensesReference =
        _collectionReference.doc(userId).collection("expenses");
    return expensesReference.get();
  }

  //update data
  static Future<void> updateExpense(
      {required String? docId, required Expense expense}) async {
    DocumentReference documentReference =
        _collectionReference.doc(userId).collection('expenses').doc(docId);

    var data = <String, dynamic>{
      "title": expense.title,
      "amount": expense.expenseAmount,
      "description": expense.description
    };

    await documentReference
        .update(data)
        .whenComplete(() => print("expense updated!"))
        .catchError((e) => print(e));
  }

  //delete data
  static Future<void> deleteExpense({required String docId}) async {
    DocumentReference documentReference =
        _collectionReference.doc(userId).collection("expenses").doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print("expense deleted!"))
        .catchError((e) => print(e));
  }

  static Future<ExpenseDTO> getTotalExpenses() async {
    QuerySnapshot expenses = await readExpenses();
    double total = 0;
    int number = 0;
    for (var i = 0; i < expenses.size; i++) {
      total += expenses.docs[i].get("amount");
      number += 1;
    }
    ExpenseDTO expenseDTO =
        ExpenseDTO(expenseAmount: total, expenseNumber: number);
    return expenseDTO;
  }
}
