import 'package:flutter/material.dart';
import 'package:tailor_app/utils/colors.dart';
import 'package:tailor_app/utils/mediaquery.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({required this.onTap, required this.text, super.key});
  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth(context) * 0.9,
        height: screenHeight(context) * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [
              AppColors.darkBlueColor,
              AppColors.lightkBlueColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: AppColors.whiteColor, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
