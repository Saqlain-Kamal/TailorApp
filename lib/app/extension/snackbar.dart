import 'package:flutter/material.dart';

extension SnackBarExtension on BuildContext {
  void mySnackBar({required String text, required Color color}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(text),
        padding: const EdgeInsets.all(12),
      ),
    );
  }
}
