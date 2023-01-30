import 'package:flutter/material.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: double.infinity,
      height: 700,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return TransactionCard(transaction: transactions[index]);
        },
        itemCount: transactions.length,
      ),
      // child: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: transactions
      //         .map((transaction) => TransactionCard(transaction: transaction))
      //         .toList()),
    );
  }
}
