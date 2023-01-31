import 'package:flutter/material.dart';

class ChartBar extends StatefulWidget {
  final Map<String, Object> transaction;
  final double weekTotal;

  const ChartBar({
    super.key,
    required this.transaction,
    required this.weekTotal,
  });

  @override
  State<ChartBar> createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar> {
  @override
  Widget build(BuildContext context) {
    String label = widget.transaction['day'] as String;
    double amount = widget.transaction['amount'] as double;
    double percent = amount == 0.0 ? 0.0 : (amount / widget.weekTotal);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: 10,
        ),
        FittedBox(
          child: Text(
            '\$$amount',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}
