class Expense {
  String? docId;
  final String? title;
  final double? expenseAmount;
  final String? description;

  Expense({
    required this.title,
    required this.expenseAmount,
    required this.description,
  });
}
