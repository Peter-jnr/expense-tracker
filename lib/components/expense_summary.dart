import 'package:expense_tracker_1/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker_1/data/expense_data.dart';
import 'package:expense_tracker_1/bar graph/bar_graph.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  // Calculate total for the week
  double calculateWeekTotal(
    Map<String, double> dailyExpenseSummary,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    return (dailyExpenseSummary[sunday] ?? 0) +
        (dailyExpenseSummary[monday] ?? 0) +
        (dailyExpenseSummary[tuesday] ?? 0) +
        (dailyExpenseSummary[wednesday] ?? 0) +
        (dailyExpenseSummary[thursday] ?? 0) +
        (dailyExpenseSummary[friday] ?? 0) +
        (dailyExpenseSummary[saturday] ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    // Generate string dates for the week
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
      builder: (context, value, child) {
        final dailySummary = value.calculateDailyExpenseSummary();

        // Ensure we have non-null values for all days
        final sundayAmount = dailySummary[sunday] ?? 0;
        final mondayAmount = dailySummary[monday] ?? 0;
        final tuesdayAmount = dailySummary[tuesday] ?? 0;
        final wednesdayAmount = dailySummary[wednesday] ?? 0;
        final thursdayAmount = dailySummary[thursday] ?? 0;
        final fridayAmount = dailySummary[friday] ?? 0;
        final saturdayAmount = dailySummary[saturday] ?? 0;

        final weekTotal = calculateWeekTotal(
          dailySummary,
          sunday,
          monday,
          tuesday,
          wednesday,
          thursday,
          friday,
          saturday,
        );

        // Determine maxY dynamically so bars scale properly
        final maxY =
            [
              sundayAmount,
              mondayAmount,
              tuesdayAmount,
              wednesdayAmount,
              thursdayAmount,
              fridayAmount,
              saturdayAmount,
            ].fold<double>(
              0,
              (prev, element) => element > prev ? element : prev,
            ) *
            1.2; // add 20% padding

        return Column(
          children: [
            // Week total display
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Text(
                    'Week Total: \$${weekTotal.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            // Week summary bar graph
            SizedBox(
              height: 200,
              child: MyBarGraph(
                sundayAmount: sundayAmount,
                mondayAmount: mondayAmount,
                tuesdayAmount: tuesdayAmount,
                wednesdayAmount: wednesdayAmount,
                thursdayAmount: thursdayAmount,
                fridayAmount: fridayAmount,
                saturdayAmount: saturdayAmount,
                maxY: maxY,
              ),
            ),
          ],
        );
      },
    );
  }
}
