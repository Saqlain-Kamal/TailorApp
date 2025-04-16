import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/extension/snackbar.dart';
import 'package:tailor_app/app/cubit/profile_cubit/profile_cubit.dart';
import 'package:tailor_app/app/cubit/profile_cubit/profile_states.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/custom_button.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            children: [
              CustomeTextField(
                controller: oldPasswordController,
                hint: 'Old Password',
                prefixIcon: 'assets/images/Lock.png',
              ),
              CustomeTextField(
                controller: newPasswordController,
                hint: 'New Password',
                prefixIcon: 'assets/images/Lock.png',
              ),
              CustomeTextField(
                controller: confirmPasswordController,
                hint: 'Confirm New Password',
                prefixIcon: 'assets/images/Lock.png',
              ),
              SizedBox(height: screenHeight(context) * 0.52), // Rep

              CustomButton(
                  isloading: context.watch<ProfileController>().isloading,
                  onTap: () async {
                    try {
                      log('message');
                      if (newPasswordController.text.trim() ==
                          confirmPasswordController.text.trim()) {
                        await context.read<ProfileController>().changePassword(
                            oldPasswordController.text.trim(),
                            newPasswordController.text.trim(),
                            context);
                      }
                      context.mySnackBar(
                          text: 'Password Changed Successfully',
                          color: AppColors.darkBlueColor);

                      Navigator.pop(context);
                      Navigator.pop(context);
                    } catch (e) {
                      context.mySnackBar(text: e.toString(), color: Colors.red);
                    }
                  },
                  text: 'Save Password'),
            ],
          ),
        ),
      ),
    );
  }
}
