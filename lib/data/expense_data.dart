import 'package:flutter/material.dart';
import '../models/expense_item.dart';
import 'hive_database.dart';
import '../datetime/date_time_helper.dart';

class ExpenseData extends ChangeNotifier {
  List<ExpenseItem> overallExpenseList = [];

  final HiveDatabase db = HiveDatabase();

  // Load data from Hive
  void prepareData() {
    overallExpenseList = db.readData();
    notifyListeners();
  }

  // Get all expenses
  List<ExpenseItem> getAllExpenseList() => overallExpenseList;

  // Add a new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    db.saveData(overallExpenseList);
    notifyListeners();
  }

  // Delete an expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    db.saveData(overallExpenseList);
    notifyListeners();
  }

  // Get day name from DateTime
  String getDayName(DateTime date) {
    switch (date.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // Start of the week
  DateTime startOfTheWeek() {
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        return today.subtract(Duration(days: i));
      }
    }
    return today;
  }

  // Calculate daily expenses for charts
  Map<String, double> calculateDailyExpense() {
    Map<String, double> dailyExpense = {};
    for (var expense in overallExpenseList) {
      String dayName = getDayName(expense.dateTime);
      dailyExpense[dayName] =
          (dailyExpense[dayName] ?? 0) + expense.amount;
    }
    return dailyExpense;
  }

  // Daily expense summary
  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};
    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount.toStringAsFixed(2));
      dailyExpenseSummary[date] = (dailyExpenseSummary[date] ?? 0) + amount;
    }
    return dailyExpenseSummary;
  }
}
