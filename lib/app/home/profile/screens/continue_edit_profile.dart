import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/model/user_model.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/viewmodel/states/auth_states.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/utils/constants.dart';
import 'package:tailor_app/utils/custom_button.dart';
import 'package:tailor_app/utils/mediaquery.dart';

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
  final stichingController = TextEditingController();
  final startingPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final id = context.read<AuthCubit>().appUser!.id;
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
                height: screenHeight(context) * 0.46,
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        AppStrings.stichingService,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    CustomeTextField(
                      controller: stichingController,
                      hint: 'Stiching Service',
                    ),
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
              SizedBox(height: screenHeight(context) * 0.3), // Rep
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
                        final createUser = UserModel(
                          name: widget.user.name,
                          email: widget.user.email,
                          phoneNumber: widget.user.phoneNumber,
                          id: id,
                          location: widget.user.location,
                          role: 'Tailor',
                          shopName: shopNameController.text.trim(),
                          experience: experienceController.text.trim(),
                          stichingService: stichingController.text.trim(),
                          startingPrice: startingPriceController.text.trim(),
                        );
                        if (widget.user.name!.isNotEmpty) {
                          await context
                              .read<AuthCubit>()
                              .updateTailorDetails(user: createUser);
                        }
                      },
                      text: 'Save Changes');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
