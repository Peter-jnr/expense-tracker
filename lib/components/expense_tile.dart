import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final double amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;

  ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: deleteTapped,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(4),
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      child: ListTile(
        title: Text(name),
        subtitle: Text('${dateTime.day}/${dateTime.month}/${dateTime.year}'),
        trailing: Text(
          '\$${amount.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
