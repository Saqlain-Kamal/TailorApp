import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/cubit/measurment_cubit/measurment_cubit.dart';
import 'package:tailor_app/app/cubit/send_request_cubit/send_request_cubit.dart';
import 'package:tailor_app/app/cubit/send_request_cubit/send_request_states.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/widgets/tailor_detail_card.dart';
import 'package:tailor_app/app/extension/padding.dart';
import 'package:tailor_app/app/extension/snackbar.dart';
import 'package:tailor_app/app/model/measurment_model.dart';
import 'package:tailor_app/app/model/user_model.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/custom_button.dart';
import '../../../../utils/mediaquery.dart';

class TailorDetail extends StatefulWidget {
  const TailorDetail({super.key, required this.tailor});
  final UserModel tailor;

  @override
  State<TailorDetail> createState() => _TailorDetailState();
}

class _TailorDetailState extends State<TailorDetail> {
  String value = '';

  @override
  void initState() {
    context.read<SendRequestCubit>().isOrderApprove(
        myUid: context.read<AuthCubit>().appUser!.id!,
        otherUid: widget.tailor.id!);
    context.read<SendRequestCubit>().isOrderSend(
        myUid: context.read<AuthCubit>().appUser!.id!,
        otherUid: widget.tailor.id!);

    context
        .read<MeasurmentCubit>()
        .getMeasurments(uid: context.read<AuthCubit>().appUser!.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(context.read<SendRequestCubit>().isOrderAlreadySend.toString());
    return Scaffold(
      // backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.tailor.name!,
          style: const TextStyle(fontSize: 20),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.favorite_border),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight(context) * 0.02,
            ),
            const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar3.png'),
                radius: 60,
              ),
            ),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
            const Center(
              child: Text(
                "15 year experience in stitching",
                style: TextStyle(fontSize: 16, color: AppColors.greyColor),
              ),
            ),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customContainer("Custom Suit"),
                SizedBox(
                  width: screenWidth(context) * 0.015,
                ),
                customContainer("Suit Alteration"),
                SizedBox(
                  width: screenWidth(context) * 0.015,
                ),
                customContainer("Dress Tailoring"),
              ],
            ),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
            const Center(
              child: Text(
                "Starting From PKR 2000",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  size: 15,
                  color: AppColors.ratingColor,
                ),
                const Text(
                  "4.8",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: screenWidth(context) * 0.015,
                ),
                const Text(
                  "(120 Reviews)",
                  style: TextStyle(fontSize: 12, color: AppColors.greyColor),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight(context) * 0.02,
            ),
            const Text(
              "Customer Reviews",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const TailorDetailCard(
                      name: 'Ali Ahmed',
                    ).paddingOnly(bottom: 5);
                  }),
            ),
            SizedBox(
              height: screenHeight(context) * 0.02,
            ),
            SizedBox(
              child: DropdownMenu(
                label: const Text('Pick Measurments'),
                enabled: true,
                enableSearch: true,
                width: screenWidth(context) * 0.7,
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
                  value = model!.name;
                  log(value);
                },
              ),
            ),
            SizedBox(
              height: screenHeight(context) * 0.02,
            ),
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
                if (state is LoadingStates) {
                  return CustomButton(
                    onTap: () {},
                    text: 'text',
                    isloading: true,
                  );
                }
                // if (state is RequestSendedStates) {
                //   WidgetsBinding.instance.addPostFrameCallback((_) {
                //     Navigator.popUntil(context, (route) => route.isFirst);
                //   });
                // }

                return CustomButton(
                  onTap: () async {
                    try {
                      context.read<SendRequestCubit>().isOrderAlreadySend
                          ? null
                          : await context
                              .read<SendRequestCubit>()
                              .sendOrderRequest(
                                  senderUser:
                                      context.read<AuthCubit>().appUser!,
                                  recieverUser: widget.tailor,
                                  senderUid:
                                      context.read<AuthCubit>().appUser!.id!,
                                  recieverUid: widget.tailor.id!);
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
                  text: context.watch<SendRequestCubit>().isOrderAlreadySend
                      ? "Request Sended"
                      : "Start Order",
                );
              },
            ),
            SizedBox(
              height: screenHeight(context) * 0.02,
            ),
            const SizedBox(),
            context.watch<SendRequestCubit>().isApproved
                ? CustomButton(
                    onTap: () {},
                    text: "Chat",
                  )
                : const SizedBox(),
            SizedBox(
              height: screenHeight(context) * 0.02,
            ),
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
