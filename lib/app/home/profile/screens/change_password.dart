import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/viewmodel/states/auth_states.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/utils/custom_button.dart';
import 'package:tailor_app/utils/mediaquery.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
              const CustomeTextField(
                hint: 'Old Password',
                prefixIcon: 'assets/images/user-edit.png',
              ),
              const CustomeTextField(
                hint: 'New Password',
                prefixIcon: 'assets/images/repeate-music.png',
              ),
              const CustomeTextField(
                hint: 'Confirm New Password',
                prefixIcon: 'assets/images/trash.png',
              ),
              SizedBox(height: screenHeight(context) * 0.52), // Rep
              BlocConsumer<AuthCubit, AuthStates>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is LoadingState) {
                    return CustomButton(
                      onTap: () {},
                      text: 'text',
                      isloading: true,
                    );
                  }

                  return CustomButton(
                      onTap: () async {
                        await context
                            .read<AuthCubit>()
                            .changePassword('123456789', '12345678');
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