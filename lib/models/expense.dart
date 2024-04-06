import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final dateFormat = DateFormat("y/M/d");

enum Category {
  food,
  travel,
  leisure,
  work,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  static int _currentIdCounterNum = 0;

  // ? You can of course use named arguments
  Expense(this.title, this.category, this.amount, this.date) {
    _currentIdCounterNum++;
  }

  // ? You can use the uuid - a third party package - to generate a string id
  final int id = _currentIdCounterNum;
  late final String title;
  late final double amount;
  late final DateTime date;
  late final Category category;

  String get formattedDate => dateFormat.format(date);
}

class ExpenseBucket {
  ExpenseBucket(this.expenses, this.category) {
    totalExpenses = getTotalExpenses();
  }

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList() {
    totalExpenses = getTotalExpenses();
  }

  double getTotalExpenses() {
    double sum = 0;

    for (var expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }

  final Category category;
  final List<Expense> expenses;
  late final double totalExpenses;
}
