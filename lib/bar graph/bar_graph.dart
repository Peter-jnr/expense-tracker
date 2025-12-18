import 'package:expense_tracker_1/bar graph/bar_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sundayAmount;
  final double mondayAmount;
  final double tuesdayAmount;
  final double wednesdayAmount;
  final double thursdayAmount;
  final double fridayAmount;
  final double saturdayAmount;

  const MyBarGraph({
    super.key,
    this.maxY,
    required this.sundayAmount,
    required this.mondayAmount,
    required this.tuesdayAmount,
    required this.wednesdayAmount,
    required this.thursdayAmount,
    required this.fridayAmount,
    required this.saturdayAmount,
  });

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sundayAmount: sundayAmount,
      mondayAmount: mondayAmount,
      tuesdayAmount: tuesdayAmount,
      wednesdayAmount: wednesdayAmount,
      thursdayAmount: thursdayAmount,
      fridayAmount: fridayAmount,
      saturdayAmount: saturdayAmount,
    );
    myBarData.initializeBarData();
    return BarChart(
      BarChartData(
        maxY: 500,
        minY: 0,
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [BarChartRodData(toY: data.y)],
              ),
            )
            .toList(),
      ),
    );
  }
}
