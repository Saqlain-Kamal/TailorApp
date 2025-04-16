import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/screens/auth_page.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/viewmodel/states/auth_states.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/screens/customer_dashboard.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = screenHeight(context);
    double width = screenWidth(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
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
              isloading: context.watch<AuthController>().isloading,
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
                  await context.read<AuthController>().getPermission();

                  if (context.read<AuthController>().currentPosition != null &&
                      context.read<AuthController>().currentDistrict != null) {
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
                          .read<AuthController>()
                          .currentPosition!
                          .latitude
                          .toString(),
                      lon: context
                          .read<AuthController>()
                          .currentPosition!
                          .longitude
                          .toString(),
                      place: context.read<AuthController>().currentDistrict,
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
                        .read<AuthController>()
                        .sighUpWithEmailAndPassword(
                          createUser,
                          widget.password,
                        );

                    if (context.read<AuthController>().appUser!.role ==
                        'Tailor') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Home(
                            index: 0,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomerHome(),
                        ),
                      );
                    }
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
        ));
  }
}
