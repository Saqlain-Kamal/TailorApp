import 'package:flutter/material.dart';
import 'package:tailor_app/app/auth/google_services/google_services.dart';
import 'package:tailor_app/app/auth/widgets/create_account_tile.dart';
import 'package:tailor_app/app/auth/widgets/social_tile.dart';
import 'package:tailor_app/utils/colors.dart';
import 'package:tailor_app/utils/constants.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({
    super.key,
    required this.cxt,
    required this.onTap,
  });
  final void Function()? onTap;
  final BuildContext cxt;
  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
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
            Column(
              children: [
                const Text(
                  AppStrings.getStarted,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const Text(
                  AppStrings.getStartedText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppColors.greyColor),
                ),
                const SizedBox(
                  height: 40,
                ),
                const CreateAccountTile(),
                const SizedBox(
                  height: 10,
                ),
                SocialTile(
                  onTap: () {
                    GoogleServices().signInWithGoogle(context);
                  },
                  image: 'assets/images/google.jpg',
                  text: ' Continue with google',
                ),
                const SizedBox(
                  height: 10,
                ),
                SocialTile(
                  onTap: () {},
                  image: 'assets/images/facebook.png',
                  text: ' Continue with facebook',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    ' Log in',
                    style: TextStyle(color: AppColors.darkBlueColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
