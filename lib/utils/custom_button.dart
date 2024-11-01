import 'package:flutter/material.dart';
import 'package:tailor_app/utils/colors.dart';
import 'package:tailor_app/utils/mediaquery.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {required this.onTap,
      required this.text,
      this.firstColor,
      this.secondColor,
      super.key});
  final void Function()? onTap;
  final String text;
  final Color? firstColor;
  final Color? secondColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth(context) * 0.9,
        height: screenHeight(context) * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              firstColor != null ? firstColor! : AppColors.darkBlueColor,
              secondColor != null ? secondColor! : AppColors.lightkBlueColor,
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
