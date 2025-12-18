import 'individual_bar.dart';

class BarData {
  final double sundayAmount;
  final double mondayAmount;
  final double tuesdayAmount;
  final double wednesdayAmount;
  final double thursdayAmount;
  final double fridayAmount;
  final double saturdayAmount;


  BarData({
    required this.sundayAmount,
    required this.mondayAmount,
    required this.tuesdayAmount,
    required this.wednesdayAmount,
    required this.thursdayAmount,
    required this.fridayAmount,
    required this.saturdayAmount,
  });

  List<IndividualBar> barData = [];
  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: sundayAmount),
      IndividualBar(x: 1, y: mondayAmount),
      IndividualBar(x: 2, y: tuesdayAmount),
      IndividualBar(x: 3, y: wednesdayAmount),
      IndividualBar(x: 4, y: thursdayAmount),
      IndividualBar(x: 5, y: fridayAmount),
      IndividualBar(x: 6, y: saturdayAmount),
    ];
  }
  
}
