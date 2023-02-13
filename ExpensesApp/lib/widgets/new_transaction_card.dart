import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';

class NewTransactionCard extends StatefulWidget {
  final Transaction transaction;
  final Function deletedTransaction;

  const NewTransactionCard({
    required Key key,
    required this.transaction,
    required this.deletedTransaction,
  }) : super(key: key);

  @override
  State<NewTransactionCard> createState() => _NewTransactionCardState();
}

class _NewTransactionCardState extends State<NewTransactionCard> {
  late Color _backgroundColor;

  @override
  void initState() {
    List<Color> availableColors = [
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.blue,
    ];

    _backgroundColor = availableColors[Random().nextInt(5)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              '\$${widget.transaction.amount}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        subtitle: Text(
          DateFormat('yyyy-MM-dd hh:mm:ss').format(widget.transaction.dateTime),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: mediaQuery.size.width > 700
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                    ),
                    onPressed: () {
                      widget.deletedTransaction(widget.transaction.id);
                    },
                  ),
                  Text(
                    'delete',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )
            : IconButton(
                icon: const Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  widget.deletedTransaction(widget.transaction.id);
                },
              ),
      ),
    );
  }
}
