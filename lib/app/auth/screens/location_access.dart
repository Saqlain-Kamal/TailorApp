import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/screens/auth_page.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/viewmodel/states/auth_states.dart';
import 'package:tailor_app/app/customer/customer_home/customer_home.dart';
import 'package:tailor_app/app/extension/snackbar.dart';
import 'package:tailor_app/app/home/home.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/custom_button.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';
import 'package:uuid/uuid.dart';

class LocationAccessScreen extends StatefulWidget {
  const LocationAccessScreen({
    super.key,
    required this.password,
    this.user,
  });
  final String password;
  final UserModel? user;

  @override
  State<LocationAccessScreen> createState() => _LocationAccessScreenState();
}

class _LocationAccessScreenState extends State<LocationAccessScreen> {
  bool isloading = false;
  @override
  void initState() {
    context.read<AuthCubit>().emit(InitialState());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = screenHeight(context);
    double width = screenWidth(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          // if (state is ErrorState) {
          //   log(state.message.toString());
          //   context.mySnackBar(
          //       text: state.message, color: Colors.red);
          // }

          if (state is AuthenticatedState) {
            state.message != null
                ? context.mySnackBar(
                    text: state.message!, color: AppColors.darkBlueColor)
                : const SizedBox();
          }
          //   final role = context.read<AuthCubit>().appUser!.role;
          //   if (role == 'Tailor') {
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const Home(index: 0),
          //       ),
          //     );
          //   } else {
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const CustomerHome(),
          //       ),
          //     );
          //   }
          // } // TODO: implement listener
        },
        builder: (context, state) {
          if (state is UnAuthenticatedState) {
            return const AuthPage();
          }
          log('asdasdasdasdadasdasd');
          log(state.toString());
          if (state is AuthenticatedState) {
            final role = context.read<AuthCubit>().appUser!.role;
            return role == 'Tailor'
                ? const Home(
                    index: 0,
                  )
                : const CustomerHome();
          }
          if (state is LoadingState) {
            log('messsssssage');

            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: AppColors.greyColor,
                ),
              ),
            );
          }
          if (state is LocationLoadingState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: height * 0.30,
                            width: width * 0.6,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(90)),
                            child:
                                Image.asset('assets/images/location copy.png'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  isloading: true,
                  onTap: () {},
                  text: 'text',
                ),
              ],
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: height * 0.30,
                          width: width * 0.6,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(90)),
                          child: Image.asset('assets/images/location copy.png'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CustomButton(
                widget: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 133, 161, 244)),
                  height: height * 0.1,
                  width: width * 0.1,
                  child: const Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                  ),
                ),
                text: 'Access Location & Sign Up',
                onTap: () async {
                  try {
                    await context.read<AuthCubit>().getPermission();

                    if (context.read<AuthCubit>().currentPosition != null &&
                        context.read<AuthCubit>().currentDistrict != null) {
                      final createUser = UserModel(
                        name: widget.user!.name,
                        email: widget.user!.email,
                        userId: const Uuid().v1(),
                        phoneNumber: widget.user!.phoneNumber,
                        role: widget.user!.role,
                        shopName: widget.user!.shopName ?? ''.trim(),
                        experience: widget.user!.experience ?? ''.trim(),
                        stichingService: widget.user!.stichingService ?? [],
                        startingPrice: widget.user!.startingPrice ?? ''.trim(),
                        lat: context
                            .read<AuthCubit>()
                            .currentPosition!
                            .latitude
                            .toString(),
                        lon: context
                            .read<AuthCubit>()
                            .currentPosition!
                            .longitude
                            .toString(),
                        place: context.read<AuthCubit>().currentDistrict,
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => LocationAccessScreen(
                      //       user: createUser,
                      //       password: widget.password.trim(),
                      //     ),
                      //   ),
                      // );

                      await context
                          .read<AuthCubit>()
                          .sighUpWithEmailAndPassword(
                            createUser,
                            widget.password,
                          );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.deepOrange,
                      content: Text(
                        e.toString(),
                      ),
                    ));
                    // setState(() {
                    //   isloading = false;
                    // });
                  }

                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(builder: (context) => const Home()),
                  // );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
