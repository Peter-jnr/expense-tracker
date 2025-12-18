import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker_1/data/expense_data.dart';
import 'package:expense_tracker_1/bar graph/bar_graph.dart';  
class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: MyBarGraph(
          sundayAmount: 20,
          mondayAmount: 50,
          tuesdayAmount: 02,
          wednesdayAmount: 50,
          thursdayAmount: 20,
          fridayAmount: 400,
          saturdayAmount: 270,
        ),
      ),
    );
  }
}
