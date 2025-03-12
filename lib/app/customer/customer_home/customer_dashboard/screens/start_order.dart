import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/auth/widgets/drop_down_type.dart';
import 'package:tailor_app/app/cubit/measurment_cubit/measurment_cubit.dart';
import 'package:tailor_app/app/cubit/send_request_cubit/send_request_cubit.dart';
import 'package:tailor_app/app/cubit/send_request_cubit/send_request_states.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/widgets/tailor_detail_card.dart';
import 'package:tailor_app/app/extension/padding.dart';
import 'package:tailor_app/app/extension/snackbar.dart';
import 'package:tailor_app/app/home/dashboard/widgets/dashboard_top.dart';
import 'package:tailor_app/app/model/measurment_model.dart';
import 'package:tailor_app/app/model/user_model.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/custom_button.dart';
import '../../../../utils/mediaquery.dart';

class StartOrder extends StatefulWidget {
  const StartOrder({super.key, required this.tailor});
  final UserModel tailor;

  @override
  State<StartOrder> createState() => _StartOrderState();
}

class _StartOrderState extends State<StartOrder> {
  MeasurmentModel? measurmentModel;

  @override
  void initState() {
    checkIsApproved();
    context.read<SendRequestCubit>().isOrderSend(
        myUid: context.read<AuthCubit>().appUser!.id!,
        otherUid: widget.tailor.id!);

    context
        .read<MeasurmentCubit>()
        .getMeasurments(uid: context.read<AuthCubit>().appUser!.id!);
    super.initState();
  }

  void checkIsApproved() async {
    await context.read<SendRequestCubit>().isOrderApprove(
        myUid: context.read<AuthCubit>().appUser!.id!,
        otherUid: widget.tailor.id!);
  }

  String? selectedValue;
  String? serviceSelectedValue;
  String? formattedDate;
  DateTime? selectedDeliveryDate;

  final chestController = TextEditingController();
  final shoulderController = TextEditingController();
  final waistController = TextEditingController();
  final lengthController = TextEditingController();
  final collarController = TextEditingController();
  final sleevesController = TextEditingController();
  final List<String> items = ['Shalwar Kameez', 'Shirt', 'Kurta'];
  @override
  Widget build(BuildContext context) {
    log(context.read<SendRequestCubit>().isOrderAlreadySend.toString());
    log(widget.tailor.stichingService.toString());
    return Scaffold(
      // backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          child: AppBar(
            clipBehavior: Clip.none,
            centerTitle: true,
            backgroundColor: AppColors.darkBlueColor,
            automaticallyImplyLeading: false,
            title: DashboardTop(
              user: widget.tailor,
            ).paddingOnly(top: 50),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
            const Text(
              "Select Service",
              style: TextStyle(fontSize: 18),
            ),
            DropDownType(
              isNotification: false,
              hintText: 'Select Service',
              selectedValue: serviceSelectedValue,
              items: widget.tailor.stichingService ?? ['hi'],
              onChanged: (p0) {
                setState(() {
                  serviceSelectedValue = p0;
                });
              },
            ),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),

            const Text(
              "Select Measurment",
              style: TextStyle(fontSize: 18),
            ),
            const Column(
              // Adjust size to fit content
              children: [
                // RadioListTile<String>(
                //   contentPadding: EdgeInsets.zero,
                //   title: const Text(
                //     'Measurements',
                //     style: TextStyle(fontSize: 15, color: AppColors.greyColor),
                //   ),
                //   value: 'Measurements', // Unique value for this option
                //   groupValue: selectedValue,
                //   onChanged: (value) {
                //     setState(() {
                //       selectedValue = value;
                //     });
                //   },
                // ),
                // RadioListTile<String>(
                //   contentPadding: EdgeInsets.zero,
                //   title: const Text(
                //     'Measurements',
                //     style: TextStyle(fontSize: 15, color: AppColors.greyColor),
                //   ),
                //   value: 'Measurements', // Unique value for this option
                //   groupValue: selectedValue,
                //   onChanged: (value) async {
                //     setState(() {
                //       selectedValue = value;
                //     });
                //   },
                // ),
                // RadioListTile<String>(
                //   contentPadding: EdgeInsets.zero,
                //   title: const Text(
                //     'Self',
                //     style: TextStyle(fontSize: 15, color: AppColors.greyColor),
                //   ),
                //   value: 'Self', // Unique value for this option
                //   groupValue: selectedValue,
                //   onChanged: (value) async {
                //     setState(() {
                //       selectedValue = value;
                //     });
                //   },
                // ),
              ],
            ),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
            DropdownMenu(
              label: const Text('Pick Measurments'),
              enabled: true,
              enableSearch: true,
              width: screenWidth(context) * 0.9,
              inputDecorationTheme: InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.borderGreyColor,
                  ),
                ),
              ),
              menuStyle: MenuStyle(
                  elevation: const WidgetStatePropertyAll(12),
                  backgroundColor:
                      WidgetStatePropertyAll(Colors.grey.shade200)),
              dropdownMenuEntries: <DropdownMenuEntry<MeasurmentModel>>[
                for (MeasurmentModel measurment
                    in context.watch<MeasurmentCubit>().measurementsList)
                  DropdownMenuEntry(
                    value: measurment,
                    label: measurment
                        .name, // Assuming there's a property called 'label' in AddressModel
                  ),

                // const DropdownMenuEntry(
                //   value: 'value',
                //   label: 'label1',
                // ),
                // const DropdownMenuEntry(
                //   value: 'value',
                //   label: 'label',
                // ),
                // const DropdownMenuEntry(
                //   value: 'value',
                //   label: 'label1',
                // ),
              ],
              onSelected: (model) {
                measurmentModel = model!;
                shoulderController.text = model.shoulder.toString();
                chestController.text = model.chest.toString();
                waistController.text = model.waist.toString();
                lengthController.text = model.length.toString();
                collarController.text = model.collar.toString();
                sleevesController.text = model.sleeves.toString();
                log(chestController.text.toString());
              },
            ),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
            Row(
              spacing: 6,
              children: [
                Expanded(
                  child: CustomeTextField(
                    controller: chestController,
                    hint: 'Chest',
                    readOnly: true,
                  ),
                ),
                Expanded(
                  child: CustomeTextField(
                    controller: shoulderController,
                    hint: 'shoulder',
                    readOnly: true,
                  ),
                ),
              ],
            ),
            Row(
              spacing: 6,
              children: [
                Expanded(
                  child: CustomeTextField(
                    controller: waistController,
                    hint: 'Waist',
                    readOnly: true,
                  ),
                ),
                Expanded(
                  child: CustomeTextField(
                    controller: lengthController,
                    hint: 'Length',
                    readOnly: true,
                  ),
                ),
              ],
            ),
            Row(
              spacing: 6,
              children: [
                Expanded(
                  child: CustomeTextField(
                    controller: waistController,
                    hint: 'Collar',
                    readOnly: true,
                  ),
                ),
                Expanded(
                  child: CustomeTextField(
                    controller: sleevesController,
                    hint: 'Sleeves',
                    readOnly: true,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
            const Text(
              "Delivery Date",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
            TextFormField(
              readOnly: true,
              controller: TextEditingController(
                text: selectedDeliveryDate != null ? formattedDate : '',
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(width: 1, color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(width: 1, color: Colors.grey.shade200),
                ),
                suffixIcon: GestureDetector(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101));
                    if (picked != null) {
                      setState(() {
                        selectedDeliveryDate = picked;
                        formattedDate = DateFormat('dd MMMM yyyy')
                            .format(selectedDeliveryDate!);
                      });
                      log('${selectedDeliveryDate!.day}-${selectedDeliveryDate!.month}-${selectedDeliveryDate!.year}');
                    }

                    // log($'{selectedDate.day}-${selectedDate.month}-${selectedDate.year}');
                  },
                  child: const Icon(
                    Icons.date_range_rounded,
                    color: AppColors.blueColor,
                  ),
                ),
                border: InputBorder.none,
                hintText: 'Select Delivery Date',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ),
            const Spacer(),
            BlocConsumer<SendRequestCubit, SendRequestStates>(
              listener: (context, state) {
                if (state is RequestSendedStates) {
                  log('ji');
                  context.mySnackBar(
                      text: 'Request Send Successfully',
                      color: AppColors.darkBlueColor);
                }
                if (state is ErrorState) {
                  log('here');
                  context.mySnackBar(text: state.message, color: Colors.red);
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is RequestSendedStates) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pop(context);
                  });
                }
                if (state is LoadingStates) {
                  return CustomButton(
                    onTap: () {},
                    text: 'text',
                    isloading: true,
                  );
                }

                if (state is CheckingLoadingStates) {
                  return const Center(
                      child: SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator()));
                }
                // if (state is RequestSendedStates) {
                //   WidgetsBinding.instance.addPostFrameCallback((_) {
                //     Navigator.popUntil(context, (route) => route.isFirst);
                //   });
                // }

                return CustomButton(
                  onTap: () async {
                    try {
                      // if (selectedValue == 'Measurements') {
                      //   if (measurmentModel == null) {
                      //     return context.mySnackBar(
                      //         text: 'Select Measurements', color: Colors.red);
                      //   }
                      // }
                      if (selectedDeliveryDate == null) {
                        return context.mySnackBar(
                            text: 'Select Delivery Date', color: Colors.red);
                      }
                      if (serviceSelectedValue == null) {
                        return context.mySnackBar(
                            text: 'Select Service', color: Colors.red);
                      }
                      context.read<SendRequestCubit>().isOrderAlreadySend ||
                              context.read<SendRequestCubit>().isApproved
                          ? null
                          : serviceSelectedValue != null
                              ? await context
                                  .read<SendRequestCubit>()
                                  .sendOrderRequest(
                                      deliveryDate: formattedDate!,
                                      measurmentModel: measurmentModel,
                                      serviceSelectedValue:
                                          serviceSelectedValue!,
                                      senderUser:
                                          context.read<AuthCubit>().appUser!,
                                      recieverUser: widget.tailor,
                                      senderUid: context
                                          .read<AuthCubit>()
                                          .appUser!
                                          .id!,
                                      recieverUid: widget.tailor.id!)
                              : context.mySnackBar(
                                  text: 'Select Measurements Type',
                                  color: Colors.red);
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
                  text: context.watch<SendRequestCubit>().isApproved
                      ? 'Request Approved'
                      : context.watch<SendRequestCubit>().isOrderAlreadySend
                          ? "Request Sended"
                          : "Place Order",
                );
              },
            ),
            SizedBox(
              height: screenHeight(context) * 0.02,
            ),
            // const SizedBox(),
            // context.watch<SendRequestCubit>().isApproved
            //     ? CustomButton(
            //         onTap: () {},
            //         text: "Chat",
            //       )
            //     : const SizedBox(),
            // SizedBox(
            //   height: screenHeight(context) * 0.02,
            // ),
          ],
        ),
      ),
    );
  }

  Container customContainer(String text) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(width: 1, color: AppColors.borderGreyColor),
          color: AppColors.whiteColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Text(
          text,
          style: const TextStyle(fontSize: 11, color: AppColors.greyColor),
        ),
      ),
    );
  }
}
