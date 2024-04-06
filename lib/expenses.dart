import 'package:expenses/expense_item.dart';
import 'package:expenses/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expenses/models/expense.dart';
import 'package:expenses/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> expenses = [
    Expense('Meat', Category.food, 25, DateTime.now()),
    Expense('New Chairs', Category.work, 50, DateTime.now()),
    Expense('Taxi', Category.travel, 75, DateTime.now()),
    Expense('Cinema', Category.leisure, 100, DateTime.now()),
    Expense('Chicken', Category.food, 25, DateTime.now()),
    Expense('A visit to pyramids', Category.leisure, 100, DateTime.now()),
  ];

  void addExpense(Expense expense) {
    setState(() {
      expenses.insert(
        0,
        expense,
      );
    });
  }

  @override
  Widget build(context) {
    final width = MediaQuery.sizeOf(context).width;
    Widget mainContent = Expanded(
      child: expenses.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                var expense = expenses[index];
                return Dismissible(
                  key: ValueKey(expense.id),
                  background: Container(
                    margin: Theme.of(context).cardTheme.margin,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  child: ExpenseItem(expense),
                  onDismissed: (direction) {
                    setState(
                      () {
                        expenses.removeAt(index);
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            padding: EdgeInsets.symmetric(
                              horizontal: width < 600 ? 16 : 32,
                            ),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "An Expense Was Removed.",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      expenses.insert(index, expense);
                                    });
                                  },
                                  child: const Text("Undo"),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              itemCount: expenses.length,
            )
          : const Center(
              child: Text(
                "There Is No Expenses",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              tooltip: "Add a new expense",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => NewExpense(addExpense),
                  isScrollControlled: true,
                  useSafeArea: true,
                  shape: Border.all(),
                );
              },
              icon: const Icon(Icons.add),
            ),
          )
        ],
      ),
      body: width < 600
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Chart(expenses: expenses),
                mainContent,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: Chart(expenses: expenses)),
                mainContent,
              ],
            ),
    );
  }
}
