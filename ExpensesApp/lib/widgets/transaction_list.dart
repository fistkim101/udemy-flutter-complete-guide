import 'package:flutter/material.dart';
import 'package:section4/widgets/new_transaction_card.dart';

import '../models/models.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;

  const TransactionList({
    super.key,
    required this.transactions,
  });

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  void _deleteTransaction(String id) {
    setState(() {
      widget.transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.transactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No transactions yet!',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 100,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ])
          : ListView(
              children: [
                ...widget.transactions
                    .map((transaction) => NewTransactionCard(
                          key: ValueKey(transaction.id),
                          transaction: transaction,
                          deletedTransaction: _deleteTransaction,
                        ))
                    .toList()
              ],
            ),
    );
  }
}
