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

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('You do not have any expenses. Add some.'),
    );
    if(_expenseList.isNotEmpty){
      
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
            mainContent
          ],
        ),
      ),
    );
  }
}