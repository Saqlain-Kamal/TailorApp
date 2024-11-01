import 'package:flutter/material.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/customer/customer_home/customer_home.dart';
import 'package:tailor_app/app/home/home.dart';
import 'package:tailor_app/utils/colors.dart';
import 'package:tailor_app/utils/constants.dart';
import 'package:tailor_app/utils/custom_button.dart';
import 'package:tailor_app/utils/mediaquery.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 50, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: screenHeight(context) * 0.15,
                child: const Column(
                  children: [
                    Text(
                      AppStrings.loginAccount,
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        AppStrings.welcomeBack,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 16, color: AppColors.greyColor),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight(context) * 0.38,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: screenHeight(context) * 0.2,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomeTextField(
                            hint: 'Email',
                            prefixIcon: 'assets/images/user2.png',
                          ),
                          CustomeTextField(
                              hint: 'Password',
                              prefixIcon: 'assets/images/user2.png'),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                Text('Forgot Password?'),
                                Text(' Reset it'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                          );
                        },
                        text: 'Login'),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CustomerHome(),
                          ),
                        );
                      },
                      child: Text("Go to Customer Home"),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight(context) * 0.32,
              ),
              const Text('Dont have an account? Create account'),
            ],
          ),
        ),
      ),
    );
  }
}
