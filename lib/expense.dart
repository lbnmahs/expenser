import 'package:flutter/material.dart';

class Expense extends StatefulWidget{
  const Expense({ super.key });

  @override
  State<Expense> createState() {
    return _Expense();
  }
}

class _Expense extends State<Expense>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: const Center(
        child: Text('Expense Tracker'),
      ),
    );
  }
}