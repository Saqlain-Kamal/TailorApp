import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/cubit/send_request_cubit/send_request_cubit.dart';
import 'package:tailor_app/app/cubit/send_request_cubit/send_request_states.dart';
import 'package:tailor_app/app/extension/snackbar.dart';
import 'package:tailor_app/app/model/measurment_model.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/constants.dart';
import 'package:tailor_app/app/utils/container_decoration.dart';
import 'package:tailor_app/app/utils/custom_button.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

class NewOrders extends StatefulWidget {
  const NewOrders(
      {super.key,
      required this.user,
      required this.orderId,
      required this.docId,
      required this.date,
      required this.deliveryDate,
      required this.measurmentModel});
  final UserModel user;
  final MeasurmentModel? measurmentModel;
  final String orderId;
  final String docId;
  final String date;
  final String deliveryDate;

  @override
  State<NewOrders> createState() => _NewOrdersState();
}

class _NewOrdersState extends State<NewOrders> {
  final chestController = TextEditingController();
  final shoulderController = TextEditingController();
  final waistController = TextEditingController();
  final lengthController = TextEditingController();
  final collarController = TextEditingController();
  final sleevesController = TextEditingController();

  @override
  void initState() {
    if (widget.measurmentModel != null) {
      chestController.text = widget.measurmentModel!.chest.toString();
      shoulderController.text = widget.measurmentModel!.shoulder.toString();
      waistController.text = widget.measurmentModel!.waist.toString();
      lengthController.text = widget.measurmentModel!.length.toString();
      collarController.text = widget.measurmentModel!.collar.toString();
      sleevesController.text = widget.measurmentModel!.sleeves.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/avatar3.png'),
                ),
                title: Text(widget.user.name!),
                subtitle: Text(widget.user.place!),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                AppStrings.orderSummary,
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: reusableBoxDecoration,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.orderId,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        Text(
                          widget.orderId,
                        ),
                      ],
                    ),
                    const Divider(
                      color: AppColors.borderGreyColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.orderDate,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        Text(
                          widget.date,
                        ),
                      ],
                    ),
                    const Divider(
                      color: AppColors.borderGreyColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.deliveryDate,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        Text(
                          widget.deliveryDate,
                        ),
                      ],
                    ),
                    const Divider(
                      color: AppColors.borderGreyColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.price,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        const Text(
                          '2000',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight(context) * 0.01,
              ),
              const Text(
                "Measurements ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: screenHeight(context) * 0.01,
              ),
              widget.measurmentModel == null
                  ? Center(
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  spreadRadius: 3,
                                  color: Colors.grey.shade300,
                                  offset: const Offset(1, 4))
                            ],
                            border: Border.all(
                                width: 2, color: AppColors.yellowColor),
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                            color: const Color.fromARGB(255, 251, 223, 139)),
                        height: screenHeight(context) * 0.08,
                        child: Center(
                            child: Column(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/alert.png',
                              height: 30,
                            ),
                            const Text(
                                'Measurements Will Be Taken From Tailor '),
                          ],
                        )),
                      ),
                    )
                  : const SizedBox(),
              widget.measurmentModel != null
                  ? Column(
                      children: [
                        Row(
                          spacing: 6,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Chest'),
                                  CustomeTextField(
                                    controller: chestController,
                                    hint: 'Chest',
                                    readOnly: true,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Shoulder'),
                                  CustomeTextField(
                                    controller: shoulderController,
                                    hint: 'shoulder',
                                    readOnly: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 6,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Waist'),
                                  CustomeTextField(
                                    controller: waistController,
                                    hint: 'Waist',
                                    readOnly: true,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Length'),
                                  CustomeTextField(
                                    controller: lengthController,
                                    hint: 'Length',
                                    readOnly: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 6,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Collar'),
                                  CustomeTextField(
                                    controller: collarController,
                                    hint: 'Collar',
                                    readOnly: true,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Sleeves'),
                                  CustomeTextField(
                                    controller: sleevesController,
                                    hint: 'Sleeves',
                                    readOnly: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : const SizedBox(),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: () async {
                        try {
                          await context
                              .read<SendRequestController>()
                              .sendOrderRequestToAdmin(
                                  orderId: widget.orderId,
                                  myUid: context
                                      .read<AuthController>()
                                      .appUser!
                                      .id!,
                                  otherUid: widget.user.id!);
                        } catch (e) {
                          if (context.mounted) {
                            context.mySnackBar(
                                text: e.toString(), color: Colors.red);
                          }
                        }

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => CustomerPayment(
                        //       user: tailor,
                        //     ),
                        //   ),
                        // );
                      },
                      text: 'ACCEPT',
                      firstColor: Colors.green.shade600,
                      secondColor: Colors.green.shade600,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomButton(
                      onTap: () async {
                        try {
                          await context
                              .read<SendRequestController>()
                              .rejectOrder(
                                  myUid: context
                                      .read<AuthController>()
                                      .appUser!
                                      .id!,
                                  otherUid: widget.user.id!);
                        } catch (e) {
                          if (context.mounted) {
                            context.mySnackBar(
                                text: e.toString(), color: Colors.red);
                          }
                        }

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => CustomerPayment(
                        //       user: tailor,
                        //     ),
                        //   ),
                        // );
                      },
                      text: 'REJECT',
                      firstColor: Colors.red.shade600,
                      secondColor: Colors.red.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
