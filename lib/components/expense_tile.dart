import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final double amount;
  final DateTime dateTime;

  const ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text('${dateTime.day}/${dateTime.month}/${dateTime.year}'),
      trailing: Text(
        '\$${amount.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
