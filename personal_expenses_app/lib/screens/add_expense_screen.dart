import 'package:flutter/material.dart';
import 'package:personal_expenses_app/data/database.dart';
import 'package:personal_expenses_app/data/database.dart';
import 'package:personal_expenses_app/data/models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);
  static const routeName = "/add-new-expense";

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Expense"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter valid title";
                        }
                        return null;
                      },
                      controller: _titleController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.title), hintText: "enter title"),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter valid description";
                        }
                        return null;
                      },
                      controller: _descriptionController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.description),
                          hintText: "enter description"),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter valid amount";
                        } else if (double.tryParse(value)! <= 0) {
                          return "Amount can't be negative or equal to 0";
                        }
                        return null;
                      },
                      controller: _amountController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.attach_money),
                          hintText: "Enter amount"),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Expense expense = Expense(
                            title: _titleController.text,
                            expenseAmount:
                                double.tryParse(_amountController.text),
                            description: _descriptionController.text,
                          );

                          Database.addExpense(expense: expense);
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Add New Expense"),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
