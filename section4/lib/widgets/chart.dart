import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class Chart extends StatefulWidget {
  final double weekTotal;
  final List<Transaction> transactions;

  const Chart({
    super.key,
    required this.weekTotal,
    required this.transactions,
  });

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  double _getWeekDaySum(DateTime weekday, List<Transaction> transactions) {
    double total = 0.0;
    for (Transaction transaction in transactions) {
      DateTime transactionCreatedAt = transaction.dateTime;
      if (weekday.day == transactionCreatedAt.day &&
          weekday.month == transactionCreatedAt.month &&
          weekday.year == transactionCreatedAt.year) {
        total += transaction.amount;
      }
    }

    return total;
  }

  List<Map<String, Object>> get _recentTransactions {
    return List.generate(7, (index) {
      final DateTime weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double total = _getWeekDaySum(weekDay, widget.transactions);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': total
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: _recentTransactions.map((transaction) {
        return ChartBar(transaction: transaction, weekTotal: widget.weekTotal);
      }).toList(),
    );
  }
}
