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
        errorColor: Colors.grey,
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
  final List<Transaction> _transactions = [];
  final transactionTitle = TextEditingController();
  final transactionAmount = TextEditingController();

  _addTransaction(String title, double amount, DateTime selectedDate) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      dateTime: selectedDate,
    );
    setState(() {
      _transactions.add(newTransaction);
    });
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void _showAddTransactionBottomSheet(BuildContext buildContext) => {
        showModalBottomSheet(
          context: buildContext,
          builder: (_) => SizedBox(
            height: 300,
            child: TransactionTextField(
              addTransaction: _addTransaction,
              transactionTitleController: transactionTitle,
              transactionAmountController: transactionAmount,
            ),
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

  List<Transaction> get _sortedTransactions {
    _transactions.sort((a, b) => -a.dateTime.compareTo(b.dateTime));
    return _transactions;
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
            TransactionList(
              transactions: _sortedTransactions,
              deletedTransaction: _deleteTransaction,
            ),
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
