import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AmountSelector extends StatelessWidget {
  final int amount;
  final String title;
  final Function(int) callback;
  final int maxAmount;

  AmountSelector(
      {Key? key,
      required this.amount,
      required this.title,
      required this.callback,
      this.maxAmount = 20})
      : super(key: key);

  Widget _amountController() {
    return Container(
      child: Row(
        children: [
          IconButton(
              onPressed: amount - 1 < 0 ? null : () => callback(amount - 1),
              icon: const Icon(Icons.arrow_downward_rounded)),
          const SizedBox(
            width: 5.0,
          ),
          Text(
            amount.toString(),
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            width: 5.0,
          ),
          IconButton(
              onPressed:
                  amount + 1 == maxAmount ? null : () => callback(amount + 1),
              icon: const Icon(Icons.arrow_upward_rounded)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _amountController()
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0)),
    );
  }
}
