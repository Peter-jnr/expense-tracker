import 'package:hive/hive.dart';
import '../models/expense_item.dart';

class HiveDatabase {
  static const String boxName = 'expense_database';

  Box get _mybox => Hive.box(boxName); // Lazy getter ensures box is opened first

  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> formattedExpenses = allExpense.map((expense) {
      return [
        expense.name,
        expense.amount,
        expense.dateTime.toIso8601String(),
      ];
    }).toList();

    _mybox.put('ALL_EXPENSES', formattedExpenses);
  }

  List<ExpenseItem> readData() {
    final savedExpenses = _mybox.get('ALL_EXPENSES', defaultValue: []);
    List<ExpenseItem> allExpense = [];

    for (var item in savedExpenses) {
      String name = item[0];
      double amount = item[1];
      DateTime dateTime = DateTime.parse(item[2]);

      allExpense.add(ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      ));
    }

    return allExpense;
  }
}