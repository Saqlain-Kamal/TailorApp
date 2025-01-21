import 'package:flutter/material.dart';
import 'package:tailor_app/app/auth/screens/create_account.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

class CreateAccountTile extends StatelessWidget {
  const CreateAccountTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateAccount(),
          ),
        );
      },
      child: Container(
        width: screenWidth(context) * 0.8,
        height: screenHeight(context) * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [
              AppColors.darkBlueColor,
              AppColors.lightkBlueColor,
            ],
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/user.png',
                color: AppColors.whiteColor,
                height: 24,
              ),
              const Text(
                ' Create account',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
