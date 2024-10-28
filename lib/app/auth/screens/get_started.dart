import 'package:flutter/material.dart';
import 'package:tailor_app/app/auth/widgets/create_account_tile.dart';
import 'package:tailor_app/app/auth/widgets/social_tile.dart';
import 'package:tailor_app/utils/colors.dart';
import 'package:tailor_app/utils/constants.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                // height: screenHeight(context) * 0.01,
                ),
            const Column(
              children: [
                Text(
                  AppStrings.getStarted,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                Text(
                  AppStrings.getStartedText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppColors.greyColor),
                ),
                SizedBox(
                  height: 40,
                ),
                CreateAccountTile(),
                SizedBox(
                  height: 10,
                ),
                SocialTile(
                  image: 'assets/images/google.jpg',
                  text: ' Continue with google',
                ),
                SizedBox(
                  height: 10,
                ),
                SocialTile(
                  image: 'assets/images/facebook.png',
                  text: ' Continue with facebook',
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                Text(
                  ' Log in',
                  style: TextStyle(color: AppColors.darkBlueColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
