import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/models.dart';
import 'widgets/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
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
  bool _showChart = true;

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

  void _showAddTransactionBottomSheet(BuildContext buildContext) => {
        showModalBottomSheet(
          isScrollControlled: true,
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

  List<Transaction> get _sortedTransactions {
    _transactions.sort((a, b) => -a.dateTime.compareTo(b.dateTime));
    return _transactions;
  }

  Widget _buildChartVisibleSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Show Chart',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Switch.adaptive(
            activeColor: Theme.of(context).colorScheme.secondary,
            value: _showChart,
            onChanged: (value) {
              setState(() {
                _showChart = value;
              });
            })
      ],
    );
  }

  double get transactionListHeight {
    if (_showChart) {
      return 0.8;
    }
    return 1.0;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
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
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (isLandScape) _buildChartVisibleSwitch(),
            if (_showChart)
              SizedBox(
                height: (mediaQuery.size.height -
                        mediaQuery.padding.top -
                        appBar.preferredSize.height) *
                    0.2,
                child: Chart(weekTotal: weekTotal, transactions: _transactions),
              ),
            SizedBox(
              height: (mediaQuery.size.height -
                      mediaQuery.padding.top -
                      appBar.preferredSize.height) *
                  transactionListHeight,
              child: TransactionList(
                transactions: _sortedTransactions,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        child: FloatingActionButton(
          child: const Icon(
            Icons.add,
          ),
          onPressed: () => {_showAddTransactionBottomSheet(context)},
        ),
      ),
    );
  }
}
