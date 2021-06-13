import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_app/data/database.dart';
import 'package:personal_expenses_app/data/models/expense.dart';
import 'package:personal_expenses_app/data/repository/expense_repository.dart';
import 'package:personal_expenses_app/screens/add_expense_screen.dart';
import 'package:provider/provider.dart';

import 'edit_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Expenses"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            child: Consumer<ExpenseRepository>(
              builder: (BuildContext context, expense, Widget? child) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: 50,
                      child: Center(
                          child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Amount:",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "${expense.expenseDTO.expenseAmount!.toStringAsFixed(2)}\$",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Expense Number:",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "${expense.expenseDTO.expenseNumber!.toString()}",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Database.readStreamExpenses(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Something went wrong!"));
                } else if (snapshot.hasData || snapshot.data != null) {
                  Provider.of<ExpenseRepository>(context, listen: false)
                      .getTotalInformation();
                  SizedBox(
                    height: 20,
                  );
                  
                  return ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                      width: double.infinity,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var docID = snapshot.data!.docs[index].id;
                      String title = snapshot.data!.docs[index].get("title");
                      String description =
                          snapshot.data!.docs[index].get("description");
                      var amount = snapshot.data!.docs[index].get("amount");

                      return Ink(
                        padding: const EdgeInsets.all(15.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                width: 2,
                                color: Colors.blue,
                                style: BorderStyle.solid), //BorderSide
                            bottom: BorderSide(
                                width: 2,
                                color: Colors.blue,
                                style: BorderStyle.solid), //BorderSide
                            left: BorderSide(
                                width: 2,
                                color: Colors.blue,
                                style: BorderStyle.solid), //Borderside
                            right: BorderSide(
                                width: 2,
                                color: Colors.blue,
                                style: BorderStyle.solid), //BorderSide
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          title: Text(
                            title,
                            style: TextStyle(fontSize: 25),
                          ),
                          subtitle: Text(
                            description,
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: Text(
                            "${snapshot.data!.docs[index].get("amount")!.toStringAsFixed(2)}\$",
                            style: TextStyle(fontSize: 25),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          onTap: () {
                            Expense expense = Expense(
                              title: title,
                              expenseAmount: amount,
                              description: description,
                            );
                            expense.docId = docID;
                            Navigator.pushNamed(context, EditScreen.routeName,
                                arguments: expense);
                          },
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: Text("Are you sure?"),
                                      content: Text(
                                          "Do you really want to delete this expense?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text("NO")),
                                        TextButton(
                                            onPressed: () {
                                              Database.deleteExpense(
                                                  docId: snapshot
                                                      .data!.docs[index].id);
                                              Navigator.pop(context);
                                            },
                                            child: Text("YES")),
                                      ],
                                    ));
                          },
                        ),
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, AddExpenseScreen.routeName),
        child: Icon(Icons.add),
      ),
    );
  }
}
