import 'package:expense_tracker/widgets/expenses/expense_list.dart';
import 'package:expense_tracker/widgets/expenses/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget{
  const Expenses({ super.key });

  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses>{
  final List<Expense> _expenseList = [
    Expense(
      title: 'Bread',
      amount: 60.0,
      date: DateTime.now(),
      category: Category.food
    ),
    Expense(
      title: 'Louis V Bag', 
      amount: 500, 
      date: DateTime.now(), 
      category: Category.travel
    )
  ];

  void _showExpenseModal() {

  }

  // Function to add an expense
  void _addExpense(Expense expense) {
    setState(() {
      _expenseList.add(expense);
    });
  }

  // Function to remove expenses
  void _removeExpense(Expense expense) {
    final expenseIndex = _expenseList.indexOf(expense);
    setState(() {
      _expenseList.remove(expenseIndex);
    });

    // confirmation scaffold
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text('The Expense has been Deleted'),
        action: SnackBarAction(
          label: 'Undo', 
          onPressed: () {
            setState(() {
              _expenseList.insert(expenseIndex, expense);
            });
          }
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('You do not have any expenses. Add some.'),
    );
    if(_expenseList.isNotEmpty){
      mainContent = ExpenseList(
        expenses: _expenseList, 
        onRemoveExpense: _removeExpense
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Text('The Chart'),
            Expanded(child: mainContent),
          ],
        ),
      ),
    );
  }
}