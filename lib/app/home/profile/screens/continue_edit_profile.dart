import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/cubit/profile_cubit/profile_cubit.dart';
import 'package:tailor_app/app/cubit/profile_cubit/profile_states.dart';
import 'package:tailor_app/app/extension/snackbar.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/constants.dart';
import 'package:tailor_app/app/utils/custom_button.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

class ContinueEditProfile extends StatefulWidget {
  const ContinueEditProfile({
    super.key,
    required this.user,
  });
  final UserModel user;
  @override
  State<ContinueEditProfile> createState() => _ContinueEditProfileState();
}

class _ContinueEditProfileState extends State<ContinueEditProfile> {
  final shopNameController = TextEditingController();
  final experienceController = TextEditingController();
  // final stichingController = TextEditingController();
  final startingPriceController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = context.read<AuthController>().appUser;

      if (user != null) {
        shopNameController.text = user.shopName!; // Set name in the controller
        experienceController.text =
            user.experience!; // Set email in the controller
        // stichingController.text =
        //     user.stichingService!; // Set phone in the controller
        startingPriceController.text =
            user.startingPrice!; // Set location in the controller
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final myUser = context.read<AuthController>().appUser!;
    // final user = context.watch<AuthController>().appUser;
    log(myUser.toJson().toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
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
                      controller: shopNameController,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        AppStrings.experience,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    CustomeTextField(
                      controller: experienceController,
                      hint: 'Experience',
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 6),
                    //   child: Text(
                    //     AppStrings.stichingService,
                    //     style: TextStyle(
                    //         fontSize: 15, fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    // CustomeTextField(
                    //   controller: stichingController,
                    //   hint: 'Stiching Service',
                    // ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        AppStrings.startingPrice,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    CustomeTextField(
                      hint: 'Starting Price',
                      controller: startingPriceController,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight(context) * 0.5), // Rep

              CustomButton(
                  isloading: context.watch<ProfileController>().isloading,
                  onTap: () async {
                    try {
                      log(myUser.role!);
                      final createUser = UserModel(
                        name: widget.user.name,
                        email: widget.user.email,
                        phoneNumber: widget.user.phoneNumber,
                        id: myUser.id,
                        userId: myUser.userId,
                        lat: myUser.lat,
                        lon: myUser.lon,
                        role: myUser.role,
                        shopName: shopNameController.text.trim(),
                        experience: experienceController.text.trim(),
                        stichingService: myUser.stichingService,
                        startingPrice: startingPriceController.text.trim(),
                      );
                      if (widget.user.name!.isNotEmpty) {
                        await context
                            .read<ProfileController>()
                            .updateTailorDetails(
                                user: createUser, context: context);
                      }
                      context.mySnackBar(
                          text: 'Profile Edited Successfully',
                          color: AppColors.darkBlueColor);

                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } catch (e) {
                      context.mySnackBar(
                          text: e.toString(), color: AppColors.darkBlueColor);
                      rethrow;
                    }
                  },
                  text: 'Save Changes'),
            ],
          ),
        ),
      ),
    );
  }
}
