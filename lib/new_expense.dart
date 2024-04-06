import 'dart:io';

import 'package:flutter/material.dart';
import 'package:expenses/models/expense.dart';
import 'package:flutter/cupertino.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.addExpense, {super.key});

  final void Function(Expense expense) addExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  var selectedCategory = Category.food;
  var selectedDate = DateTime.now();

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    /* 
      we wanted this to make the list scrollable when 
      we open the keyboard, but actually now we don't need
      this. 
    */
    // final keyboardSpace = MediaQuery.viewInsetsOf(context);
    // print(keyboardSpace);

    final List<Widget> textFields = [
      TextField(
        decoration: const InputDecoration(
          label: Text("The title of the expense...."),
          prefixText: '- ',
        ),
        maxLength: 50,
        controller: titleController,
      ),
      TextField(
        decoration: const InputDecoration(
          label: Text("Amount"),
          prefixText: r'$ ',
          counterText: '',
        ),
        keyboardType: TextInputType.number,
        controller: amountController,
      ),
    ];

    final List<Widget> filledButtons = [
      FilledButton.tonal(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("Cancel"),
      ),
      const SizedBox(width: 10),
      FilledButton(
        onPressed: () {
          var amount = double.tryParse(amountController.text);
          var title = titleController.text;

          if (title.trim().isEmpty || amount == null || amount < 0) {
            if (Platform.isIOS || Platform.isMacOS) {
              showCupertinoDialog(
                context: context,
                builder: (ctx) => CupertinoAlertDialog(
                  title: const Text("Error!"),
                  content: const Text(
                    "Make sure that title is not empty and that amount is valid",
                  ),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Okay"),
                    ),
                  ],
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text(
                    "Error!",
                    textAlign: TextAlign.center,
                  ),
                  content: const Text(
                    "Make sure that title is not empty and that amount is valid!",
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    // TODO: change text buttons color because it is not convenient.
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("Okay"),
                    )
                  ],
                  actionsAlignment: MainAxisAlignment.center,
                ),
              );
            }
            return;
          }

          widget.addExpense(
            Expense(title, selectedCategory, amount, selectedDate),
          );
          Navigator.pop(context);
        },
        child: const Text("Save Expense"),
      )
    ];

    return LayoutBuilder(builder: (ctx, constrains) {
      final width = constrains.maxWidth;
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            if (width <= 600)
              ...textFields
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: textFields[0]),
                  const SizedBox(width: 20),
                  Expanded(child: textFields[1]),
                ],
              ),
            const SizedBox(height: 30),
            Row(
              children: [
                DropdownButton(
                  value: selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                ),
                const Spacer(),
                Text(dateFormat.format(selectedDate)),
                IconButton(
                  onPressed: () {
                    final now = DateTime.now();

                    showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: now.subtract(
                        const Duration(days: 20 * 365),
                      ),
                      lastDate: now,
                    ).then((value) {
                      setState(() {
                        selectedDate = value ?? selectedDate;
                      });
                    });
                  },
                  icon: const Icon(Icons.date_range),
                ),
                if (width > 600) const Spacer(),
                if (width > 600) ...filledButtons
              ],
            ),
            const SizedBox(height: 30),
            if (width <= 600)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: filledButtons,
              )
          ],
        ),
      );
    });
  }
}
