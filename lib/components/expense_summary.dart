import 'package:expense_tracker_1/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker_1/data/expense_data.dart';
import 'package:expense_tracker_1/bar graph/bar_graph.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    // get dates for the week
    String sunday = convertDateTimeToString(
      startOfWeek.add(const Duration(days: 0)),
    );
    String monday = convertDateTimeToString(
      startOfWeek.add(const Duration(days: 1)),
    );
    String tuesday = convertDateTimeToString(
      startOfWeek.add(const Duration(days: 2)),
    );
    String wednesday = convertDateTimeToString(
      startOfWeek.add(const Duration(days: 3)),
    );
    String thursday = convertDateTimeToString(
      startOfWeek.add(const Duration(days: 4)),
    );
    String friday = convertDateTimeToString(
      startOfWeek.add(const Duration(days: 5)),
    );
    String saturday = convertDateTimeToString(
      startOfWeek.add(const Duration(days: 6)),
    );

    return Consumer<ExpenseData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: MyBarGraph(
          sundayAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
          mondayAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
          tuesdayAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
          wednesdayAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
          thursdayAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
          fridayAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
          saturdayAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
        ),
      ),
    );
  }
}
