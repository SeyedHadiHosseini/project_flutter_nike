import 'package:flutter/material.dart';

class ReceiverDeliveryCart extends StatelessWidget {
  final String text;
  final TextEditingController controller;

  const ReceiverDeliveryCart({
    Key? key,
    required this.text, required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: text),
      ),
    );
  }
}
