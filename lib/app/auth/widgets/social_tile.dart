import 'package:flutter/material.dart';
import 'package:tailor_app/utils/colors.dart';
import 'package:tailor_app/utils/mediaquery.dart';

class SocialTile extends StatelessWidget {
  const SocialTile({
    super.key,
    required this.image,
    required this.text,
  });
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context) * 0.8,
      height: screenHeight(context) * 0.06,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.borderGreyColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 25,
            ),
            Text(
              text,
            ),
          ],
        ),
      ),
    );
  }
}
