
import 'package:flutter/material.dart';

class ComputingCartPrices extends StatelessWidget {
  const ComputingCartPrices({
    Key? key,
    required this.textComputing,
    required this.textComment,
  }) : super(key: key);

  final String textComment;
  final Widget textComputing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(textComment),
          textComputing,
        ],
      ),
    );
  }
}
