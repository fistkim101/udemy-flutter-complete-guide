import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletedTransaction;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.deletedTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: double.infinity,
      height: 600,
      child: Center(
        child: transactions.isEmpty
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
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                        ),
                        onPressed: () {
                          deletedTransaction(transaction.id);
                        },
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
