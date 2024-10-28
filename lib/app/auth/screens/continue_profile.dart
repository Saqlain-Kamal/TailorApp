import 'package:flutter/material.dart';
import 'package:tailor_app/app/auth/screens/login.dart';
import 'package:tailor_app/app/auth/widgets/custom_button.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/utils/colors.dart';
import 'package:tailor_app/utils/constants.dart';
import 'package:tailor_app/utils/mediaquery.dart';

class ContinueProfile extends StatelessWidget {
  const ContinueProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 10),
          child: SizedBox(
            height: screenHeight(context) * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    Text(
                      AppStrings.welcomeText,
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        AppStrings.getStartedText,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 16, color: AppColors.greyColor),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.borderGreyColor,
                      child: Icon(Icons.camera),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppStrings.uploadProfile,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight(context) * 0.46,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          AppStrings.shopName,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      CustomeTextField(
                        hint: 'Shop Name',
                        prefixIcon: 'assets/images/user2.png',
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          AppStrings.experience,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      CustomeTextField(
                        hint: 'Experience',
                        prefixIcon: 'assets/images/user2.png',
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          AppStrings.stichingService,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      CustomeTextField(
                        hint: 'Stiching Service',
                        prefixIcon: 'assets/images/user2.png',
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          AppStrings.startingPrice,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      CustomeTextField(
                        hint: 'Starting Price',
                        prefixIcon: 'assets/images/user2.png',
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  text: 'Save',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
