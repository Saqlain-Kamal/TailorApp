import 'package:flutter/material.dart';
import 'package:tailor_app/app/auth/google_services/google_services.dart';
import 'package:tailor_app/app/auth/widgets/create_account_tile.dart';
import 'package:tailor_app/app/auth/widgets/social_tile.dart';
import 'package:tailor_app/app/utils/border_custom_button.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/constants.dart';
import 'package:tailor_app/app/utils/custom_button.dart';

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
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return RoleSelectionDialogue(
                          onTap: (value) {
                            GoogleServices().signInWithGoogle(context, value);
                            Navigator.pop(ctx);
                          },
                        );
                      },
                    );
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

class RoleSelectionDialogue extends StatelessWidget {
  const RoleSelectionDialogue({
    required this.onTap,
    super.key,
  });
  final void Function(String)? onTap;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Column(
        children: [
          Image.asset(
            'assets/images/management.png',
            height: 70,
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            AppStrings.accountType,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.accountTypeBrief,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
          ),
          Text(
            AppStrings.accountTypeCarefully,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
          ),
        ],
      ),
      actions: [
        BorderCustomButton(onTap: () => onTap?.call('Tailor'), text: 'Tailor'),
        const SizedBox(
          height: 10,
        ),
        CustomButton(onTap: () => onTap?.call('Customer'), text: 'Customer')
      ],
    );
  }
}
