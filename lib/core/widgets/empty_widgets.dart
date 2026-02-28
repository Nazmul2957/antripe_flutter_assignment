import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No data found',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}