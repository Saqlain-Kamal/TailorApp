import 'package:flutter/material.dart';
import 'package:tailor_app/app/auth/screens/continue_profile.dart';
import 'package:tailor_app/app/auth/widgets/custom_button.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/auth/widgets/drop_down_type.dart';
import 'package:tailor_app/utils/colors.dart';
import 'package:tailor_app/utils/constants.dart';
import 'package:tailor_app/utils/mediaquery.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final List<String> items = ['Tailor', 'Customer', 'Rider'];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 10),
          child: SizedBox(
            height: screenHeight(context) * 0.91,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    Text(
                      AppStrings.createAccount,
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
                  ],
                ),
                SizedBox(
                  height: screenHeight(context) * 0.65,
                  child: Column(
                    children: [
                      const CustomeTextField(
                        prefixIcon: 'assets/images/user2.png',
                        hint: 'Full Name',
                      ),
                      const CustomeTextField(
                        prefixIcon: 'assets/images/user2.png',
                        hint: 'Email',
                      ),
                      const CustomeTextField(
                        prefixIcon: 'assets/images/user2.png',
                        hint: 'Password',
                      ),
                      const CustomeTextField(
                        prefixIcon: 'assets/images/user2.png',
                        hint: 'Confirm Password',
                      ),
                      const CustomeTextField(
                        prefixIcon: 'assets/images/user2.png',
                        hint: 'Phone Number',
                      ),
                      const CustomeTextField(
                        prefixIcon: 'assets/images/user2.png',
                        hint: 'Location',
                      ),
                      DropDownType(
                        selectedValue: selectedValue,
                        items: items,
                        onChanged: (p0) {
                          setState(() {
                            selectedValue = p0;
                          });
                        },
                      )
                    ],
                  ),
                ),
                CustomButton(
                  text: 'Sign In',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContinueProfile(),
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
