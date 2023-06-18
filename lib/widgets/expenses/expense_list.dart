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
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
            ),
            margin: const EdgeInsets.only(left: 5),
          ),
          onDismissed: (direction) {
            onRemoveExpense(expenseList[index]);
          },
          child: ExpenseCard(expense: expenseList[index]),
        );
      }
    );
  }
}
