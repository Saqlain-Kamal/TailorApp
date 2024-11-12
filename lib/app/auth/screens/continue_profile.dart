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
import 'package:tailor_app/app/auth/model/user_model.dart';
import 'package:tailor_app/app/auth/screens/auth_page.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/viewmodel/states/auth_states.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/customer/customer_home/customer_home.dart';
import 'package:tailor_app/app/home/home.dart';
import 'package:tailor_app/utils/colors.dart';
import 'package:tailor_app/utils/constants.dart';
import 'package:tailor_app/utils/custom_button.dart';
import 'package:tailor_app/utils/mediaquery.dart';

import 'auth_page.dart';

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

  @override
  Widget build(BuildContext context) {
    context.read<AuthCubit>().emit(InitialState());
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthStates>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: AppColors.greyColor,
                ),
              ),
            );
          }

          // if (state is ErrorState) {
          //   return Center(
          //     child: Text(
          //       'Error: ${state.message}',
          //       style: const TextStyle(color: Colors.red),
          //     ),
          //   );
          // }
          if (state is UnAuthenticatedState) {
            return const AuthPage();
          }
          if (state is AuthenticatedState) {
            // Once authenticated, navigate to the home screen or show a success message
            final role = context.read<AuthCubit>().appUser!.role;
            return role == 'Tailor' ? const Home() : const CustomerHome();
            // Removes all previous routes

            // Example: Navigate to Home screen
          }

          // Default UI when no specific state is triggered
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 50, left: 15, right: 15, bottom: 10),
              child: SizedBox(
                height: screenHeight(context) * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      children: [
                        Text(
                          AppStrings.welcomeText,
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            AppStrings.getStartedText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, color: AppColors.greyColor),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.borderGreyColor,
                          child: Image(
                              image: AssetImage('assets/images/Camera.png')),
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
                            controller: stichingServiceController,
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
                    CustomButton(
                      text: 'Save',
                      onTap: () async {
                        try {
                          final createUser = UserModel(
                            name: widget.user.name,
                            email: widget.user.email,
                            phoneNumber: widget.user.phoneNumber,
                            location: widget.user.location,
                            role: widget.user.role,
                            shopName: shopNameController.text.trim(),
                            experience: experienceController.text.trim(),
                            stichingService:
                                stichingServiceController.text.trim(),
                            startingPrice: startingPriceController.text.trim(),
                          );
                          // context.read<AuthCubit>().emit(LoadingState());
                          await context
                              .read<AuthCubit>()
                              .sighUpWithEmailAndPassword(
                                createUser,
                                widget.password,
                              );
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
