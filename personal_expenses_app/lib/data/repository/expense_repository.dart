import 'package:flutter/material.dart';
import 'package:personal_expenses_app/data/models/expenseDTO.dart';

import '../database.dart';

class ExpenseRepository extends ChangeNotifier {
  ExpenseDTO expenseDTO = ExpenseDTO(expenseAmount: 0, expenseNumber: 0);

  void getTotalInformation() {
    Database.getTotalExpenses().then((expenseDTO) => {
          this.expenseDTO.expenseAmount = expenseDTO.expenseAmount,
          this.expenseDTO.expenseNumber = expenseDTO.expenseNumber,
          notifyListeners()
        });
  }
}
