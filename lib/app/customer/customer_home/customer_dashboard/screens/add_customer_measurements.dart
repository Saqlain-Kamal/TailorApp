import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/cubit/measurment_cubit/measurment_cubit.dart';
import 'package:tailor_app/app/cubit/measurment_cubit/measurment_states.dart';
import 'package:tailor_app/app/extension/snackbar.dart';
import 'package:tailor_app/app/model/measurment_model.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/custom_button.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

class AddMeasurements extends StatefulWidget {
  const AddMeasurements({super.key});

  @override
  State<AddMeasurements> createState() => _AddMeasurementsState();
}

class _AddMeasurementsState extends State<AddMeasurements> {
  bool isloading = false;

  final collarController = TextEditingController();
  final nameController = TextEditingController();
  final shoulderController = TextEditingController();
  final sleevesController = TextEditingController();
  final chestController = TextEditingController();
  final waistController = TextEditingController();
  final lengthController = TextEditingController();
  String label = '';
  final formKey = GlobalKey<FormState>();
  // static const LatLng loc = LatLng(37.4223, -10.0848);

  @override
  void initState() {
    // context.read<MeasurmentCubit>().emit(InitialStates());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: FocusScope(
        child: Form(
          key: formKey,
          child: Column(children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(10),
            //   child: Container(
            //     color: AppColor.lightOrangeColor,
            //     height: screenHeight(context) * 0.35,
            //     width: double.infinity,
            //     child: GoogleMap(
            //       onTap: (argument) {
            //         print(argument);
            //       },
            //       initialCameraPosition: CameraPosition(
            //           target: context.read<GetPermissionLocation>().currentPosition ??
            //               loc,
            //           zoom: 5),
            //       markers: {
            //         Marker(
            //           markerId: const MarkerId('value'),
            //           icon: BitmapDescriptor.defaultMarker,
            //           position:
            //               context.read<GetPermissionLocation>().currentPosition ??
            //                   loc,
            //         )
            //       },
            //     ),
            //   ),
            // ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: SizedBox(
                        height: screenHeight(context) * 0.9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'MEASURMENTS',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Image.asset(
                                      'assets/images/kurta.png',
                                      height: 100,
                                    ),
                                  ],
                                ),
                                const Text('Name'),
                                CustomeTextField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  hint: 'Name',
                                  controller: nameController,
                                ),
                                const Text('COLLAR'),
                                CustomeTextField(
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    hint: 'Collar',
                                    controller: collarController),
                                const Text('SHOULDER'),
                                CustomeTextField(
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    hint: 'shoulder',
                                    controller: shoulderController),
                                const Text('SLEEVES'),
                                CustomeTextField(
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    hint: 'sleeves',
                                    controller: sleevesController),
                                const Text('CHEST'),
                                CustomeTextField(
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    hint: 'chest',
                                    controller: chestController),
                                const Text('WAIST'),
                                CustomeTextField(
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    hint: 'waist',
                                    controller: waistController),
                                const Text('LENGTH'),
                                CustomeTextField(
                                    keyboardType: TextInputType.number,
                                    hint: 'length',
                                    controller: lengthController),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           const Text('STREET'),
                            //           CustomeTextField(
                            //               hint: 'Gulbahar',
                            //               controller: streetController)
                            //         ],
                            //       ),
                            //     ),
                            //     const SizedBox(
                            //       width: 15,
                            //     ),
                            //     Expanded(
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           const Text('POSTAL CODE'),
                            //           CustomeTextField(
                            //               hint: '25000',
                            //               controller: postalController)
                            //         ],
                            //       ),
                            //     )
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      label = 'Shalwar Kameez';
                                    });
                                    print(label);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 25),
                                    decoration: BoxDecoration(
                                        color: label == 'Shalwar Kameez'
                                            ? AppColors.darkBlueColor
                                            : AppColors.borderGreyColor,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Text(
                                      'Shalwar Kameez',
                                      style: TextStyle(
                                          color: label == 'Shalwar Kameez'
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      label = 'Shirt';
                                    });
                                    print(label);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 25),
                                    decoration: BoxDecoration(
                                        color: label == 'Shirt'
                                            ? AppColors.darkBlueColor
                                            : AppColors.borderGreyColor,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Text(
                                      'Shirt',
                                      style: TextStyle(
                                          color: label == 'Shirt'
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      label = 'Other';
                                    });
                                    print(label);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 25),
                                    decoration: BoxDecoration(
                                        color: label == 'Other'
                                            ? AppColors.darkBlueColor
                                            : AppColors.borderGreyColor,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Text(
                                      'Other',
                                      style: TextStyle(
                                          color: label == 'Other'
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                )
                              ],
                            ),

                            CustomButton(
                              onTap: label.isNotEmpty
                                  ? () async {
                                      if (formKey.currentState!.validate()) {}
                                      log('message');
                                      try {
                                        final measurement = MeasurmentModel(
                                            chest:
                                                int.parse(chestController.text),
                                            collar: int.parse(
                                                collarController.text),
                                            shoulder: int.parse(
                                                shoulderController.text),
                                            sleeves: int.parse(
                                                sleevesController.text),
                                            length: int.parse(
                                                lengthController.text),
                                            waist:
                                                int.parse(waistController.text),
                                            uid: context
                                                .read<AuthController>()
                                                .appUser!
                                                .id!,
                                            label: label,
                                            name: nameController.text.trim());

                                        context
                                            .read<MeasurmentController>()
                                            .addMeasurement(
                                                measurement: measurement);
                                      } catch (e) {
                                        context.mySnackBar(
                                            text: e.toString(),
                                            color: Colors.red);
                                      }
                                    }
                                  : null,
                              text: 'Save Measurments',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}
