import 'package:flutter/material.dart';

class EmptyListSpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 40,
          color: Colors.grey[100],
        ),
      ),
    );
  }
}