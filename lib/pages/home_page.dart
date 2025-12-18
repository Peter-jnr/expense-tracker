import 'package:expense_tracker_1/components/expense_summary.dart';
import 'package:expense_tracker_1/components/expense_tile.dart';
import 'package:expense_tracker_1/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final TextEditingController newExpenseDollarController =
      TextEditingController();
  final TextEditingController newExpenseCentController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: newExpenseDollarController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(labelText: 'Dollars'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: newExpenseCentController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    decoration: const InputDecoration(labelText: 'Cents'),
                  ),
                ),
              ],
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

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  void save() {
    final name = newExpenseNameController.text.trim();
    final dollar = newExpenseDollarController.text.trim();
    final cent = newExpenseCentController.text.trim();

    if ([name, dollar, cent].any((e) => e.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields before saving.')),
      );
      return;
    }

    final amount = double.tryParse('$dollar.$cent');
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid positive amount.')),
      );
      return;
    }

    final newExpense = ExpenseItem(
      name: name,
      amount: amount,
      dateTime: DateTime.now(),
    );

    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

    newExpenseNameController.clear();
    newExpenseDollarController.clear();
    newExpenseCentController.clear();

    Navigator.of(context).pop(); // close dialog
  }

  void cancel() {
    // Clear controllers on cancel too
    newExpenseNameController.clear();
    newExpenseDollarController.clear();
    newExpenseCentController.clear();
    Navigator.of(context).pop(); // close dialog
  }

  @override
  void dispose() {
    newExpenseNameController.dispose();
    newExpenseDollarController.dispose();
    newExpenseCentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense, // it works now
          backgroundColor: Colors.black,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: ListView(
          children: [
            //will add bar graph here later
            ExpenseSummary(startOfWeek: value.startOfTheWeek()),
            const SizedBox(height: 20),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpenseList()[index].name,
                amount: value.getAllExpenseList()[index].amount,
                dateTime: value.getAllExpenseList()[index].dateTime,
                deleteTapped: (p0) =>
                    deleteExpense(value.getAllExpenseList()[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
