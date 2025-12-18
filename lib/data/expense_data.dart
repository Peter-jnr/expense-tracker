import 'package:expense_tracker_1/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_1/datetime/date_time_helper.dart';

class ExpenseData extends ChangeNotifier {
  List<ExpenseItem> overallExpenseList = [];

  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  // add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    notifyListeners();
  }

  // delete expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
  }

  // for getting day name from date
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

  //get start of the week
  DateTime startOfTheWeek() {
    DateTime? startOfTheWeek;
    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfTheWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfTheWeek!;
  }

  Map<String, double> calculateDailyExpense() {
    Map<String, double> dailyExpense = {};

    for (int i = 0; i < overallExpenseList.length; i++) {
      String dayName = getDayName(overallExpenseList[i].dateTime);
      if (dailyExpense.containsKey(dayName)) {
        dailyExpense[dayName] =
            dailyExpense[dayName]! + overallExpenseList[i].amount;
      } else {
        dailyExpense[dayName] = overallExpenseList[i].amount;
      }
    }
    return dailyExpense;
  }

  // get weekly expense
  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount.toStringAsFixed(2));

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]! + amount;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
