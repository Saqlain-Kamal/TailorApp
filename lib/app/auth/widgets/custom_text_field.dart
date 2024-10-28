import 'package:flutter/material.dart';
import 'package:tailor_app/utils/colors.dart';

class CustomeTextField extends StatelessWidget {
  const CustomeTextField({
    super.key,
    required this.hint,
    required this.prefixIcon,
  });
  final String prefixIcon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: TextFormField(
        cursorColor: AppColors.darkBlueColor,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
            child: Image.asset(
              prefixIcon,
              color: Colors.grey.shade500,
              height: 10,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 12, horizontal: 10), // Adjust padding here,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(width: 1, color: AppColors.borderGreyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(width: 1, color: AppColors.darkBlueColor),
          ),
        ),
      ),
    );
  }
}
