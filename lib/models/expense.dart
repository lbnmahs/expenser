import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum Category { food, leisure, work, travel }

const categoryIcons = {
  Category.food: Icons.food_bank_rounded,
  Category.leisure: Icons.movie_filter_rounded,
  Category.work: Icons.work_history_rounded,
  Category.travel: Icons.travel_explore_rounded
};

final formatter = DateFormat.yMd();

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBar {
  const ExpenseBar({
    required this.expenses, 
    required this.category
  });

  final List<Expense> expenses;
  final Category category;

  ExpenseBar.forCategory(
    this.category,
    List<Expense> allExpenses
  ) : expenses = allExpenses.where(
    (expense) => category == expense.category
  ).toList();

  double get totalAmount {
    double sum = 0;
    for(final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}