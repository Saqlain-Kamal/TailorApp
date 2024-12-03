import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/extension/snackbar.dart';
import 'package:tailor_app/app/profile_cubit/profile_cubit.dart';
import 'package:tailor_app/app/profile_cubit/profile_states.dart';
import 'package:tailor_app/utils/colors.dart';
import 'package:tailor_app/utils/custom_button.dart';
import 'package:tailor_app/utils/mediaquery.dart';

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
              BlocConsumer<ProfileCubit, ProfileStates>(
                listener: (context, state) {
                  // TODO: implement listener

                  if (state is PasswordChangedState) {
                    log('ji');
                    context.mySnackBar(
                        text: 'Password Changed Successfully',
                        color: AppColors.darkBlueColor);
                  }
                },
                builder: (context, state) {
                  if (state is LoadingStates) {
                    return CustomButton(
                      onTap: () {},
                      text: 'text',
                      isloading: true,
                    );
                  }
                  if (state is PasswordChangedState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  }

                  return CustomButton(
                      onTap: () async {
                        log('message');
                        if (newPasswordController.text.trim() ==
                            confirmPasswordController.text.trim()) {
                          await context.read<ProfileCubit>().changePassword(
                              oldPasswordController.text.trim(),
                              newPasswordController.text.trim(),
                              context);
                        }
                      },
                      text: 'Save Password');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
