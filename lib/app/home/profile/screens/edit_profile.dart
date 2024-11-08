import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tailor_app/app/auth/model/user_model.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/home/profile/screens/continue_edit_profile.dart';
import 'package:tailor_app/utils/bottom_sheet.dart';
import 'package:tailor_app/utils/custom_button.dart';
import 'package:tailor_app/utils/mediaquery.dart';

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
  Widget build(BuildContext context) {
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
                          location: locationController.text.trim(),
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
