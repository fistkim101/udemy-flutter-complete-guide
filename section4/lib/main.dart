import 'package:flutter/material.dart';

import 'models/models.dart';
import 'widgets/widgets.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> _transactions = [
    Transaction(
        id: 1, title: 'mac studio', amount: 101.5, dateTime: DateTime.now()),
    Transaction(id: 2, title: 'iphone', amount: 8.5, dateTime: DateTime.now()),
    // Transaction(id: 3, title: 'coke', amount: 101.5, dateTime: DateTime.now()),
    // Transaction(
    //     id: 4, title: 'sneakers', amount: 101.5, dateTime: DateTime.now()),
  ];
  final transactionTitle = TextEditingController();
  final transactionAmount = TextEditingController();

  _addTransaction(String title, double amount) {
    final newTransaction = Transaction(
      title: title,
      amount: amount,
      dateTime: DateTime.now(),
    );
    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Section4'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TransactionTextField(
              addTransaction: _addTransaction,
              transactionTitleController: transactionTitle,
              transactionAmountController: transactionAmount,
            ),
            TransactionList(transactions: _transactions),
          ],
        ),
      ),
    );
  }
}
