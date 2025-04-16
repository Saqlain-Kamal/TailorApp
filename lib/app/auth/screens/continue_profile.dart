// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tailor_app/app/auth/model/user_model.dart';
// import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
// import 'package:tailor_app/app/auth/viewmodel/states/auth_states.dart';
// import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
// import 'package:tailor_app/utils/colors.dart';
// import 'package:tailor_app/utils/constants.dart';
// import 'package:tailor_app/utils/custom_button.dart';
// import 'package:tailor_app/utils/mediaquery.dart';

// class ContinueProfile extends StatefulWidget {
//   const ContinueProfile(
//       {super.key, required this.user, required this.password});
//   final UserModel user;
//   final String password;
//   @override
//   State<ContinueProfile> createState() => _ContinueProfileState();
// }

// class _ContinueProfileState extends State<ContinueProfile> {
//   final shopNameController = TextEditingController();
//   final experienceController = TextEditingController();
//   final stichingServiceController = TextEditingController();
//   final startingPriceController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding:
//               const EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 10),
//           child: SizedBox(
//             height: screenHeight(context) * 0.9,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Column(
//                   children: [
//                     Text(
//                       AppStrings.welcomeText,
//                       style:
//                           TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: Text(
//                         AppStrings.getStartedText,
//                         textAlign: TextAlign.center,
//                         style:
//                             TextStyle(fontSize: 16, color: AppColors.greyColor),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundColor: AppColors.borderGreyColor,
//                       child:
//                           Image(image: AssetImage('assets/images/Camera.png')),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       AppStrings.uploadProfile,
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: screenHeight(context) * 0.46,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 6),
//                         child: Text(
//                           AppStrings.shopName,
//                           style: TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       CustomeTextField(
//                         hint: 'Shop Name',
//                         prefixIcon: 'assets/images/user2.png',
//                         controller: shopNameController,
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 6),
//                         child: Text(
//                           AppStrings.experience,
//                           style: TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       CustomeTextField(
//                         controller: experienceController,
//                         hint: 'Experience',
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 6),
//                         child: Text(
//                           AppStrings.stichingService,
//                           style: TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       CustomeTextField(
//                         controller: stichingServiceController,
//                         hint: 'Stiching Service',
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 6),
//                         child: Text(
//                           AppStrings.startingPrice,
//                           style: TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       CustomeTextField(
//                         hint: 'Starting Price',
//                         controller: startingPriceController,
//                       ),
//                     ],
//                   ),
//                 ),
//                 CustomButton(
//                   text: 'Save',
//                   onTap: () async {
//                     try {
//                       final createUser = UserModel(
//                         name: 'jamal',
//                         email: 'zxzzx@gmail.com',
//                         phoneNumber: '34234234',
//                         location: 'asdasdasd',
//                         role: 'Tailor',
//                         shopName: 'asfasfasdasd',
//                         experience: 'asfasfasdad',
//                         stichingService: 'afasdasdasdasd',
//                         startingPrice: 'asdasdsadasd',
//                       );
//                       context.read<AuthCubit>().emit(LoadingState());
//                       await context
//                           .read<AuthCubit>()
//                           .sighUpWithEmailAndPassword(
//                             createUser,
//                             '1231231231',
//                           );
//                     } catch (e) {
//                       log(e.toString());
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/screens/location_access.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/viewmodel/states/auth_states.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/constants.dart';
import 'package:tailor_app/app/utils/custom_button.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';
import 'package:uuid/uuid.dart';

class ContinueProfile extends StatefulWidget {
  const ContinueProfile(
      {super.key, required this.user, required this.password});
  final UserModel user;
  final String password;

  @override
  State<ContinueProfile> createState() => _ContinueProfileState();
}

class _ContinueProfileState extends State<ContinueProfile> {
  final shopNameController = TextEditingController();
  final experienceController = TextEditingController();
  final stichingServiceController = TextEditingController();
  final startingPriceController = TextEditingController();

  List<TextEditingController> controllers = [];

  @override
  void initState() {
    // TODO: implement initState

    controllers.add(TextEditingController());
    super.initState();
  }

  void _addTextField() {
    setState(() {
      controllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

          // if (state is ErrorState) {
          //   return Center(
          //     child: Text(
          //       'Error: ${state.message}',
          //       style: const TextStyle(color: Colors.red),
          //     ),
          //   );
          // }
          // if (state is UnAuthenticatedState) {
          //   return const AuthPage();
          // }
          // if (state is AuthenticatedState) {
          //   return LocationAccessScreen(
          //     role: context.read<AuthCubit>().appUser!.role!,
          //     user: context.read<AuthCubit>().appUser,
          //   );
          //   // Once authenticated, navigate to the home screen or show a success message
          //   // final role = context.read<AuthCubit>().appUser!.role;
          //   // return role == 'Tailor'
          //   //     ? const Home(
          //   //         index: 0,
          //   //       )
          //   //     : const CustomerHome();
          //   // Removes all previous routes

          //   // Example: Navigate to Home screen
          // }

          // Default UI when no specific state is triggered
          SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 10),
          child: SizedBox(
            height: screenHeight(context) * 0.9,
            child: Column(
              children: [
                const Column(
                  children: [
                    Text(
                      AppStrings.welcomeText,
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
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.borderGreyColor,
                      child:
                          Image(image: AssetImage('assets/images/camera.png')),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppStrings.uploadProfile,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight(context) * 0.55,
                  child: ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
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
                      SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            growable: true,
                            controllers.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: CustomeTextField(
                                    hint: 'Service',
                                    controller: controllers[index],
                                  )),
                                  if (index ==
                                      controllers.length -
                                          1) // Show add button only on last field
                                    GestureDetector(
                                      onTap: _addTextField,
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          gradient: const LinearGradient(
                                            colors: [
                                              AppColors
                                                  .darkBlueColor, // Use your AppColors here
                                              AppColors.blueColor,
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
                const Spacer(),
                CustomButton(
                  text: 'Save',
                  onTap: () async {
                    try {
                      List<String> services = controllers
                          .map((controller) => controller.text.trim())
                          .toList();
                      final createUser = UserModel(
                        name: widget.user.name,
                        email: widget.user.email,
                        userId: const Uuid().v1(),
                        phoneNumber: widget.user.phoneNumber,
                        role: widget.user.role,
                        shopName: shopNameController.text.trim(),
                        experience: experienceController.text.trim(),
                        stichingService: services,
                        startingPrice: startingPriceController.text.trim(),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationAccessScreen(
                            user: createUser,
                            password: widget.password.trim(),
                          ),
                        ),
                      );
                      // context.read<AuthCubit>().emit(LoadingState());
                      // await context
                      //     .read<AuthCubit>()
                      //     .sighUpWithEmailAndPassword(
                      //       createUser,
                      //       widget.password,
                      //     );
                    } catch (e) {
                      log(e.toString());
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
