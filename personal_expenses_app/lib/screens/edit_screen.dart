import 'package:flutter/material.dart';
import 'package:personal_expenses_app/data/database.dart';
import 'package:personal_expenses_app/data/models/expense.dart';

class EditScreen extends StatefulWidget {
  static const routeName = "/edit-expense";

  const EditScreen({Key? key}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    final expense = ModalRoute.of(context)!.settings.arguments as Expense;

    _titleController = TextEditingController(text: expense.title);
    _amountController =
        TextEditingController(text: expense.expenseAmount!.toStringAsFixed(2));
    _descriptionController = TextEditingController(text: expense.description);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Expense"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
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
                        icon: Icon(Icons.title), hintText: "Enter title"),
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
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid description";
                      }
                      return null;
                    },
                    controller: _descriptionController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.description),
                        hintText: "Enter description"),
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
                    keyboardType: TextInputType.number,
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
                        icon: Icon(Icons.attach_money), hintText: "Enter amount"),
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
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Expense editedExpense  = Expense(
                          title: _titleController.text,
                          expenseAmount:
                              double.tryParse(_amountController.text),
                          description: _descriptionController.text,
                        );
                        Database.updateExpense(
                            docId: expense.docId, expense: editedExpense);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Edit Expense"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
