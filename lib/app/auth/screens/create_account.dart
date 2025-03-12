import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/screens/continue_profile.dart';
import 'package:tailor_app/app/auth/screens/location_access.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/auth/widgets/drop_down_type.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/constants.dart';
import 'package:tailor_app/app/utils/custom_button.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final List<String> items = ['Tailor', 'Customer', 'Rider'];

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final locationController = TextEditingController();

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
                      CustomeTextField(
                        prefixIcon: 'assets/images/user2.png',
                        hint: 'Full Name',
                        controller: nameController,
                      ),
                      CustomeTextField(
                        prefixIcon: 'assets/images/user2.png',
                        hint: 'Email',
                        controller: emailController,
                      ),
                      CustomeTextField(
                        prefixIcon: 'assets/images/Lock.png',
                        hint: 'Password',
                        controller: passwordController,
                      ),
                      CustomeTextField(
                        prefixIcon: 'assets/images/Lock.png',
                        hint: 'Confirm Password',
                        controller: confirmPasswordController,
                      ),
                      CustomeTextField(
                        prefixIcon: 'assets/images/user2.png',
                        hint: 'Phone Number',
                        controller: phoneNumberController,
                      ),
                      // CustomeTextField(
                      //   prefixIcon: 'assets/images/location.png',
                      //   hint: 'Location',
                      //   controller: locationController,
                      // ),
                      DropDownType(
                        isNotification: false,
                        prefixImage: 'assets/images/tag-user.png',
                        hintText: 'Select Role',
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
                  text: 'Continue',
                  onTap: () {
                    final user = UserModel(
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                      phoneNumber: phoneNumberController.text.trim(),
                      // location: locationController.text.trim(),
                      role: selectedValue,
                    );

                    if (selectedValue == 'Customer') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationAccessScreen(
                            password: passwordController.text.trim(),
                            user: user,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContinueProfile(
                            password: passwordController.text.trim(),
                            user: user,
                          ),
                        ),
                      );
                    }
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
