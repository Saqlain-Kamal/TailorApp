import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:lottie/lottie.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

class BorderCustomButton extends StatelessWidget {
  const BorderCustomButton(
      {required this.onTap,
      required this.text,
      this.firstColor,
      this.secondColor,
        this.textColor,
      this.isloading,
      super.key});
  final void Function()? onTap;
  final String text;
  final Color? firstColor;
  final Color? secondColor;
  final Color? textColor;
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
          border: GradientBoxBorder(
            gradient: LinearGradient(
              colors: [
                firstColor != null ? firstColor! : AppColors.darkBlueColor,
                secondColor != null ? secondColor! :AppColors.blueColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          // Border.all(width: 1.5, color: Colors.grey.shade300)
        ),
        child: isloading != null
            ? Lottie.asset(
                'assets/images/whiteLoading.json',
                height: 100,
              )
            : Center(
                child: Text(
                  text,
                  style:  TextStyle(
                      color: textColor != null ? textColor! : AppColors.darkBlueColor, fontSize: 14),
                ),
              ),
      ),
    );
  }
}
