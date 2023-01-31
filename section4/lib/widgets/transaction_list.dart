import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      child: Center(
        child: transactions.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                    Text(
                      'No transactions yet!',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: 100,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ])
            : ListView.builder(
                itemBuilder: (context, index) {
                  Transaction transaction = transactions[index];

                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 5,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            '\$${transaction.amount}',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                      title: Text(
                        transaction.title,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      subtitle: Text(
                        DateFormat('yyyy-MM-dd hh:mm:ss')
                            .format(transaction.dateTime),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  );
                  // return TransactionCard(transaction: transactions[index]);
                },
                itemCount: transactions.length,
              ),
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
