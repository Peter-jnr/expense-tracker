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

    // Determine dynamic maxY
    double calculatedMaxY =
        maxY ??
        (myBarData.barData.isNotEmpty
            ? myBarData.barData
                      .map((data) => data.y)
                      .fold<double>(
                        0,
                        (prev, element) => element > prev ? element : prev,
                      ) *
                  1.2
            : 10); // Minimum maxY so graph shows even if empty

    return BarChart(
      BarChartData(
        maxY: calculatedMaxY,
        minY: 0,
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
              reservedSize: 32,
            ),
          ),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barsSpace: 4, // spacing between bars in a group
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.grey[800],
                    width: 25,
                    borderRadius: BorderRadius.circular(5),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: calculatedMaxY,
                      color: Colors.grey[200],
                    ),
                  ),
                ],
              ),
            )
            .toList(),
        alignment: BarChartAlignment.spaceAround,
        barTouchData: BarTouchData(enabled: false),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('Sun', style: style);
      break;
    case 1:
      text = const Text('Mon', style: style);
      break;
    case 2:
      text = const Text('Tue', style: style);
      break;
    case 3:
      text = const Text('Wed', style: style);
      break;
    case 4:
      text = const Text('Thu', style: style);
      break;
    case 5:
      text = const Text('Fri', style: style);
      break;
    case 6:
      text = const Text('Sat', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(meta: meta, space: 6, child: text);
}
