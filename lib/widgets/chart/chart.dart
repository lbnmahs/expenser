import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBar> get bars {
    return [
      ExpenseBar.forCategory(Category.food, expenses),
      ExpenseBar.forCategory(Category.leisure, expenses),
      ExpenseBar.forCategory(Category.work, expenses),
      ExpenseBar.forCategory(Category.travel, expenses),
    ];
  }

  // getter to get the max total spendings
  double get maxTotalSpending {
    double maxSpending = 0;
    for (final bar in bars) {
      if (bar.totalAmount > maxSpending) {
        maxSpending = bar.totalAmount;
      }
    }
    return maxSpending;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.5),
            Theme.of(context).colorScheme.primary.withOpacity(0.1)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
      child: Column(
        children: [
          // bar
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for(final bar in bars)
                  ChartBar(
                    fill: bar.totalAmount == 0
                    ? 0
                    : bar.totalAmount / maxTotalSpending
                  )
              ]
            ),
          ),
          const SizedBox(height: 8,),
          // Icons
          Row(
            children: bars.map(
              (bar) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    categoryIcons[bar.category],
                    color: isDarkMode 
                    ? Theme.of(context).colorScheme.secondary 
                    : Theme.of(context).colorScheme.primary.withOpacity(0.5)
                  ),
                )
              )
            ).toList(),
          )
        ],
      ),
    );
  }
}
