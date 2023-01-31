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
        primarySwatch: Colors.red,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
            .copyWith(secondary: Colors.amber),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 17,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          toolbarTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
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
      id: 1,
      title: 'mac studio',
      amount: 101.5,
      dateTime: DateTime.now().subtract(
        const Duration(days: 1),
      ),
    ),
    Transaction(
      id: 2,
      title: 'iphone',
      amount: 90.23,
      dateTime: DateTime.now().subtract(
        const Duration(days: 2),
      ),
    ),
    Transaction(
      id: 3,
      title: 'iphone X',
      amount: 70.15,
      dateTime: DateTime.now().subtract(
        const Duration(days: 3),
      ),
    ),
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

  void _showAddTransactionBottomSheet(BuildContext buildContext) => {
        showModalBottomSheet(
          context: buildContext,
          builder: (_) => TransactionTextField(
            addTransaction: _addTransaction,
            transactionTitleController: transactionTitle,
            transactionAmountController: transactionAmount,
          ),
        )
      };

  double get weekTotal {
    double total = 0.0;
    for (var transaction in _transactions) {
      total += transaction.amount;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Section4'),
        titleTextStyle: Theme.of(context).appBarTheme.toolbarTextStyle,
        actions: [
          IconButton(
            onPressed: () => {_showAddTransactionBottomSheet(context)},
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Chart(weekTotal: weekTotal, transactions: _transactions),
            TransactionList(transactions: _transactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () => {_showAddTransactionBottomSheet(context)},
      ),
    );
  }
}
