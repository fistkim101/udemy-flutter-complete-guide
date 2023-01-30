import 'dart:ffi';

import 'package:flutter/material.dart';

class TransactionTextField extends StatefulWidget {
  Function addTransaction;
  TextEditingController transactionTitleController;
  TextEditingController transactionAmountController;

  TransactionTextField({
    super.key,
    required this.addTransaction,
    required this.transactionTitleController,
    required this.transactionAmountController,
  });

  @override
  State<TransactionTextField> createState() => _TransactionTextFieldState();
}

class _TransactionTextFieldState extends State<TransactionTextField> {
  void submit() {
    String title = widget.transactionTitleController.text;
    double amount = double.parse(widget.transactionAmountController.text);
    if (title.isEmpty || amount <= 0) {
      return;
    }

    widget.addTransaction(title, amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: widget.transactionTitleController,
              onSubmitted: (_) => {submit()},
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: widget.transactionAmountController,
              onSubmitted: (_) => {submit()},
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            MaterialButton(
              textColor: Colors.purple,
              onPressed: () => {submit()},
              child: const Text('Add transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
