import 'dart:io';

import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({ super.key, required this.onAddExpense });

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _textController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  // Function to select a date
  void _openDatePicker () async {
    final now = DateTime.now();
    final finalDate = DateTime(now.year -1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context, 
      initialDate: now, 
      firstDate: finalDate, 
      lastDate: now
    );
    
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // Function to show Dialog
  void _showDialog() {
    if(Platform.isIOS){
      showCupertinoDialog(
        context: context, 
        builder: (ctx) => CupertinoAlertDialog(
          title:  const Text('Invalid Input'),
          content: const Text('Please make sure all inputs are valid'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: const Text('Okay')
            )
          ],
        )
      );
    }else {
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title:  const Text('Invalid Input'),
          content: const Text('Please make sure all inputs are valid'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('Okay')
            )
          ],
        ) 
      );
    }
  }

  // Function to add an expense
  void _submitExpense () {
    final enteredAmount = double.tryParse(_amountController.text);
    final isAmountInvalid = enteredAmount == null || enteredAmount <= 0;

    if(_textController.text.isEmpty || isAmountInvalid || _selectedDate == null){
      _showDialog();
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _textController.text, 
        amount: enteredAmount, 
        date: _selectedDate!, 
        category: _selectedCategory
      )
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _textController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // First Row
                  width >= 600 
                  ? Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          maxLength: 50,
                          decoration: const InputDecoration(label: Text('Title'))
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          maxLength: 10,
                          decoration: const InputDecoration(label: Text('Amount'))
                        ),
                      ),
                    ],
                  )
                  : TextField(
                    controller: _textController,
                    maxLength: 50,
                    decoration: const InputDecoration(label: Text('Title'))
                  ),

                  const SizedBox(height: 12,),

                  // Second Row
                  width >= 600
                  ? Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values.map(
                          (category) => DropdownMenuItem(
                            child: Text(category.name)
                          )
                        ).toList(), 
                        onChanged: (value) {
                          if(value == null){
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        }
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: _openDatePicker, 
                              icon: const Icon(Icons.date_range_rounded)
                            ),
                            Text(
                              _selectedDate == null
                              ? 'Select Date'
                              : formatter.format(_selectedDate!)
                            )
                          ]
                        )
                      )
                    ],
                  )
                  : Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          maxLength: 10,
                          decoration: const InputDecoration(label: Text('Amount'))
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: _openDatePicker, 
                              icon: const Icon(Icons.date_range_rounded)
                            ),
                            Text(
                              _selectedDate == null
                              ? 'Select Date'
                              : formatter.format(_selectedDate!)
                            )
                          ]
                        )
                      )
                    ]
                  ),

                  const SizedBox(height: 12,),

                  width >= 600
                  ? Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed: _submitExpense, 
                        child: const Text('Save Expense')
                      ),
                      const SizedBox(width: 5,),
                      TextButton(
                        onPressed: () => Navigator.pop(context), 
                        child: const Text('Cancel')
                      )
                    ],
                  )
                  : Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values.map(
                          (category) => DropdownMenuItem(
                            child: Text(category.name)
                          )
                        ).toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        }
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: _submitExpense, 
                        child: const Text('Save Expense')
                      ),
                      const SizedBox(width: 5,),
                      TextButton(
                        onPressed: () => Navigator.pop(context), 
                        child: const Text('Cancel')
                      )
                    ],
                  )

                ],
              )
            ),
          ),
        );
      }
    );
  }
}