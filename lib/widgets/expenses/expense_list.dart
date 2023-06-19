import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses/expense_card.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key, 
    required this.expenses, 
    required this.onRemoveExpense
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) {
        return Dismissible(
          key: ValueKey(expenses[index]), 
          background: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error.withOpacity(0.7),
              borderRadius: BorderRadius.circular(5)
            ),
            margin: const EdgeInsets.only(left: 5),
          ),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          child: ExpenseCard(expense: expenses[index]),
        );
      }
    );
  }
}
