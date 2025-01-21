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
      this.widget,
      super.key});
  final void Function()? onTap;
  final String text;
  final Color? firstColor;
  final Color? secondColor;
  final bool? isloading;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onTap == null;
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        width: screenWidth(context) * 0.95,
        height: screenHeight(context) * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: isDisabled
              ? null // No gradient for disabled state
              : LinearGradient(
                  colors: [
                    firstColor ?? AppColors.darkBlueColor,
                    secondColor ?? AppColors.lightkBlueColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          color: isDisabled ? Colors.grey : null,
        ),
        child: isloading != null
            ? Lottie.asset(
                'assets/images/whiteLoading.json',
                height: 100,
              )
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                          color: AppColors.whiteColor, fontSize: 14),
                    ),
                    if (widget != null)
                      const SizedBox(
                        width: 20,
                      ),
                    if (widget != null) widget!,
                  ],
                ),
              ),
      ),
    );
  }
}
