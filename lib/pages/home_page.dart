import 'package:expense_tracker_1/components/expense_summary.dart';
import 'package:expense_tracker_1/components/expense_tile.dart';
import 'package:expense_tracker_1/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker_1/data/expense_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController newExpenseNameController =
      TextEditingController();
  final TextEditingController newExpenseAmountController =
      TextEditingController();

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add New Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newExpenseNameController,
              decoration: const InputDecoration(labelText: 'Expense title'),
            ),
            TextField(
              controller: newExpenseAmountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          MaterialButton(onPressed: save, child: const Text('Save')),
          MaterialButton(onPressed: cancel, child: const Text('Cancel')),
        ],
      ),
    );
  }

  void save() {
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: double.parse(newExpenseAmountController.text),
      dateTime: DateTime.now(),
    );

    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

    // Clear controllers after saving
    newExpenseNameController.clear();
    newExpenseAmountController.clear();

    Navigator.of(context).pop(); // close dialog
  }

  void cancel() {
    // Clear controllers on cancel too
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
    Navigator.of(context).pop(); // close dialog
  }

  @override
  void dispose() {
    newExpenseNameController.dispose();
    newExpenseAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[200],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense, // it works now
          child: const Icon(Icons.add),
        ),
        body: ListView(
          children: [
            //will add bar graph here later
            ExpenseSummary(startOfWeek: value.startOfTheWeek()),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpenseList()[index].name,
                amount: value.getAllExpenseList()[index].amount,
                dateTime: value.getAllExpenseList()[index].dateTime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
