import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses/expense_card.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key, 
    required this.expenseList, 
    required this.onRemoveExpense
  });

  final List<Expense> expenseList;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenseList.length,
      itemBuilder: (ctx, index) {
        return Dismissible(
          key: ValueKey(expenseList[index]), 
          child: ExpenseCard(expense: expenseList[index])
        );
      }
    );
  }
}
