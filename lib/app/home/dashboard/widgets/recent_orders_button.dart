import 'package:flutter/material.dart';
import 'package:tailor_app/utils/colors.dart';

class RecentOrdersButton extends StatelessWidget {
  const RecentOrdersButton({
    required this.text,
    super.key,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: AppColors.borderGreyColor),
      ),
      child: Text(text),
    );
  }
}
