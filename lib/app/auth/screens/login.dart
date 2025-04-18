// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/screens/customer_dashboard.dart';
import 'package:tailor_app/app/customer/customer_home/customer_home.dart';
import 'package:tailor_app/app/extension/snackbar.dart';
import 'package:tailor_app/app/home/home.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/constants.dart';
import 'package:tailor_app/app/utils/custom_button.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.onTap});
  final void Function()? onTap;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomeTextField(
                            hint: 'Email',
                            prefixIcon: 'assets/images/user2.png',
                            controller: emailController,
                          ),
                          CustomeTextField(
                            hint: 'Password',
                            prefixIcon: 'assets/images/user2.png',
                            controller: passwordController,
                          ),
                          const Padding(
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
                        isloading: context.watch<AuthController>().isloading,
                        onTap: () async {
                          try {
                            await context
                                .read<AuthController>()
                                .sighInWithEmailAndPassword(
                                    emailController.text.trim(),
                                    passwordController.text.trim());

                            if (context.read<AuthController>().appUser!.role ==
                                'Tailor') {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const Home(
                              //       index: 0,
                              //     ),
                              //   ),
                              // );
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Home(index: 0)),
                                  (predicate) => false);
                            } else {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CustomerDashboard()),
                                  (predicate) => false);
                            }
                          } catch (e) {
                            context.mySnackBar(
                                text: e.toString(), color: Colors.red);
                          }
                        },
                        text: 'Login'),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const CustomerHome(),
                    //       ),
                    //     );
                    //   },
                    //   child: const Text("Go to Customer Home"),
                    // )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight(context) * 0.32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dont have an account? '),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Create account',
                        style: TextStyle(
                            color: AppColors.darkBlueColor,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
