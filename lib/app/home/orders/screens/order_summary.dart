import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/cubit/send_request_cubit/send_request_cubit.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/screens/review.dart';
import 'package:tailor_app/app/model/measurment_model.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/constants.dart';
import 'package:tailor_app/app/utils/container_decoration.dart';
import 'package:tailor_app/app/utils/custom_button.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

import '../../profile/widgets/custom_alert_dialogue.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({
    super.key,
    required this.user,
    required this.orderId,
    required this.docId,
    required this.date,
    required this.deliveryDate,
    required this.measurmentModel,
    required this.status,
    this.isShowReviewDialogue,
  });
  final UserModel user;
  final String orderId;
  final String docId;
  final String date;
  final String deliveryDate;

  final MeasurmentModel? measurmentModel;
  final String status;
  final bool? isShowReviewDialogue;

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override
  void initState() {
    super.initState();
    // Show the dialog only when the status is "Delivered"

    log(context.read<AuthCubit>().appUser!.role.toString());
    if (widget.status == 'Delivered' &&
        context.read<AuthCubit>().appUser!.role == 'Customer' &&
        widget.isShowReviewDialogue == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        _showDeliveredDialog();
        await context.read<SendRequestCubit>().updateDialogueBool(
            myUid: context.read<AuthCubit>().appUser!.id!,
            otherUid: widget.user.id!);
      });
    }
  }

  void _showDeliveredDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialogue(
          image: 'assets/images/done.png',
          title: 'Your order has been Delivered successfully',
          desc: "Thank you for choosing us. We'll hope to start an order again",
          showBtn1: false,
          btnText2: 'Leave Review',
          btnOnTap2: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddReview(
                  user: widget.user,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const LatLng loc = LatLng(37.4223, -10.0848);
    log(context.read<AuthCubit>().currentPosition.toString());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/images/avatar3.png'),
                    ),
                    title: Text(widget.user.name!),
                    subtitle: Text(widget.user.email!),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          color: widget.status == 'In Progress'
                              ? AppColors.blueColor
                              : widget.status == 'Pending'
                                  ? AppColors.goldenColor
                                  : Colors.green,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        widget.status,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
                              '2000 (COD)',
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: screenHeight(context) * 0.35,
                      width: double.infinity,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: widget.user.lat != null
                                ? LatLng(double.tryParse(widget.user.lat!)!,
                                    double.tryParse(widget.user.lon!)!)
                                : loc,
                            zoom: 10),
                        markers: {
                          Marker(
                            markerId: const MarkerId('value'),
                            icon: BitmapDescriptor.defaultMarker,
                            position: widget.user.lat != null
                                ? LatLng(double.tryParse(widget.user.lat!)!,
                                    double.tryParse(widget.user.lon!)!)
                                : loc,
                          )
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  widget.measurmentModel == null
                      ? Center(
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(-1, -1),
                                      blurRadius: 10,
                                      spreadRadius: 10,
                                      color: Colors.grey.shade100)
                                ],
                                border: Border.all(
                                    width: 2, color: AppColors.yellowColor),
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                                color:
                                    const Color.fromARGB(255, 251, 223, 139)),
                            height: screenHeight(context) * 0.08,
                            child: const Center(
                                child: Column(
                              spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Measurements Will Be Taken From Tailor '),
                              ],
                            )),
                          ),
                        )
                      : const SizedBox(),
                  const Spacer(),
                  CustomButton(
                    onTap: () {},
                    text: "Chat",
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
