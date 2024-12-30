import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {required this.onTap,
      required this.text,
      this.firstColor,
      this.secondColor,
      this.isloading,
      super.key});
  final void Function()? onTap;
  final String text;
  final Color? firstColor;
  final Color? secondColor;
  final bool? isloading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth(context) * 0.95,
        height: screenHeight(context) * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: [
              firstColor != null ? firstColor! : AppColors.darkBlueColor,
              secondColor != null ? secondColor! : AppColors.lightkBlueColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: isloading != null
            ? Lottie.asset(
                'assets/images/whiteLoading.json',
                height: 100,
              )
            : Center(
                child: Text(
                  text,
                  style: const TextStyle(
                      color: AppColors.whiteColor, fontSize: 14),
                ),
              ),
      ),
    );
  }
}
