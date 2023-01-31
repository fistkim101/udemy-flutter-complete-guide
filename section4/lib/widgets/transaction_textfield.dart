import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  DateTime? _selectedDate;

  void _showDatePickerModal(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2024),
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          _selectedDate = selectedDate;
        });
      }
    });
  }

  void submit(BuildContext buildContext) {
    String title = widget.transactionTitleController.text;
    double amount = double.parse(widget.transactionAmountController.text);
    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTransaction(title, amount, _selectedDate);
    Navigator.of(buildContext).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: widget.transactionTitleController,
              onSubmitted: (_) => {submit(context)},
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: widget.transactionAmountController,
              onSubmitted: (_) => {submit(context)},
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date selected'
                        : 'Picked Date : ${DateFormat.yMd().format(_selectedDate!)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                GestureDetector(
                  onTap: () => {_showDatePickerModal(context)},
                  child: Text(
                    'Choose Date',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () => {submit(context)},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero, // and this
              ),
              child: Text(
                'Add transaction',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
