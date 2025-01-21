import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/cubit/profile_cubit/profile_cubit.dart';
import 'package:tailor_app/app/cubit/profile_cubit/profile_states.dart';
import 'package:tailor_app/app/home/profile/screens/continue_edit_profile.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/utils/bottom_sheet.dart';
import 'package:tailor_app/app/utils/custom_button.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = context.read<AuthCubit>().appUser;
      context.read<ProfileCubit>().emit(InitialStates());
      if (user != null) {
        nameController.text = user.name!; // Set name in the controller
        emailController.text = user.email!; // Set email in the controller
        phoneController.text =
            user.phoneNumber ?? ''; // Set phone in the controller
        // locationController.text =
        //     user.location!; // Set location in the controller
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthCubit>().appUser;
    log(user!.toJson().toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 70,
                          backgroundImage:
                              AssetImage('assets/images/avatar2.png'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return ModelBottomSheet(
                                    onImageSelected: (img) {
                                      log(img.toString());
                                    },
                                  );
                                },
                              );
                            },
                            child: Image.asset(
                              'assets/images/Dot.png',
                              height: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomeTextField(
                      hint: 'Name',
                      prefixIcon: 'assets/images/user2.png',
                      controller: nameController,
                    ),
                    CustomeTextField(
                      readOnly: true,
                      hint: 'Email',
                      prefixIcon: 'assets/images/user2.png',
                      controller: emailController,
                    ),
                    CustomeTextField(
                      hint: 'Phone',
                      prefixIcon: 'assets/images/user2.png',
                      controller: phoneController,
                    ),
                    CustomeTextField(
                      hint: 'Location',
                      prefixIcon: 'assets/images/location.png',
                      controller: locationController,
                    ),
                    SizedBox(
                        height: screenHeight(context) *
                            0.3), // Replace Spacer with SizedBox
                    // BlocConsumer<AuthCubit, AuthStates>(
                    //   listener: (context, state) {
                    //     // TODO: implement listener
                    //   },
                    //   builder: (context, state) {
                    //     if (state is LoadingState) {
                    //       return CustomButton(
                    //         onTap: () {},
                    //         text: 'Next',
                    //         isloading: true,
                    //       );
                    //     } else {
                    //       return CustomButton(
                    //         onTap: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) =>
                    //                   const ContinueEditProfile(),
                    //             ),
                    //           );
                    //         },
                    //         text: 'Next',
                    //       );
                    //     }
                    //   },
                    // ),
                    CustomButton(
                      onTap: () async {
                        final user = UserModel(
                          name: nameController.text.trim(),
                          email: emailController.text.trim(),
                          phoneNumber: phoneController.text.trim(),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContinueEditProfile(
                              user: user,
                            ),
                          ),
                        );
                      },
                      text: 'Next',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
