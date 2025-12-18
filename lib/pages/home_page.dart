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

  void save() {
    // Construct the amount string and convert it to double
    String amountString =
        '${newExpenseDollarController.text}.${newExpenseCentController.text}';
    double amount = double.tryParse(amountString) ?? 0.0; // safely parse

    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: amount, // ✅ double now
      dateTime: DateTime.now(),
    );

    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

    // Clear controllers after saving
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
