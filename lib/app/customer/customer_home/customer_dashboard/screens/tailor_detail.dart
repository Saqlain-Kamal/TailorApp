import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/cubit/favorite_cubit/favorite_cubit.dart';
import 'package:tailor_app/app/cubit/measurment_cubit/measurment_cubit.dart';
import 'package:tailor_app/app/cubit/send_request_cubit/send_request_cubit.dart';
import 'package:tailor_app/app/cubit/send_request_cubit/send_request_states.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/screens/start_order.dart';
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
  MeasurmentModel? measurmentModel;
  bool isFavorite = false;
  @override
  void initState() {
    context
        .read<FavoriteController>()
        .isFavorite(widget.tailor, context)
        .then((value) {
      setState(() {
        isFavorite = value;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        checkIsApproved();
      },
    );
    context.read<SendRequestController>().isOrderSend(
        myUid: context.read<AuthController>().appUser!.id!,
        otherUid: widget.tailor.id!);

    // context
    //     .read<MeasurmentCubit>()
    //     .getMeasurments(uid: context.read<AuthController>().appUser!.id!);
    super.initState();
  }

  void checkIsApproved() async {
    await context.read<SendRequestController>().isOrderApprove(
        myUid: context.read<AuthController>().appUser!.id!,
        otherUid: widget.tailor.id!);
  }

  void toggleFavorite({required UserModel user}) {
    setState(() {
      isFavorite = !isFavorite; // Update UI immediately
    });

    if (isFavorite) {
      context.read<FavoriteController>().addToFav(
          user: user, uid: context.read<AuthController>().appUser!.id!);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
        duration: Duration(seconds: 2),
        backgroundColor: AppColors.darkBlueColor,
        content: Text("Added To Favorites"),
      ));
    } else {
      context.read<FavoriteController>().removeItemFromCart(
          user: user, uid: context.read<AuthController>().appUser!.id!);
      context.mySnackBar(
          text: 'Removed From Favorites', color: AppColors.darkBlueColor);
    }
  }

  String? selectedValue = '';

  @override
  Widget build(BuildContext context) {
    log(context.read<SendRequestController>().isOrderAlreadySend.toString());
    return Scaffold(
      // backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.tailor.shopName!,
          style: const TextStyle(fontSize: 20),
        ),
        actions: [
          GestureDetector(
            onTap: () => toggleFavorite(user: widget.tailor),
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 30,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
            ),
          ),
          const Padding(
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
            Center(
              child: Text(
                "${widget.tailor.experience} year experience in stitching",
                style:
                    const TextStyle(fontSize: 16, color: AppColors.greyColor),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Customer Reviews",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.darkBlueColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight(context) * 0.015,
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
              height: screenHeight(context) * 0.01,
            ),
            CustomButton(
              onTap: context.watch<SendRequestController>().isApproved
                  ? null
                  : () async {
                      // try {
                      //   if (measurmentModel == null) {
                      //     return context.mySnackBar(
                      //         text: 'Select Measurements', color: Colors.red);
                      //   } else {}
                      //   context.read<SendRequestController>().isOrderAlreadySend
                      //       ? null
                      //       : await context
                      //           .read<SendRequestController>()
                      //           .sendOrderRequest(
                      //               senderUser:
                      //                   context.read<AuthController>().appUser!,
                      //               recieverUser: widget.tailor,
                      //               senderUid:
                      //                   context.read<AuthController>().appUser!.id!,
                      //               recieverUid: widget.tailor.id!);
                      // } catch (e) {
                      //   if (context.mounted) {
                      //     context.mySnackBar(
                      //         text: e.toString(), color: Colors.red);
                      //   }
                      // }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StartOrder(
                            tailor: widget.tailor,
                          ),
                        ),
                      );
                    },
              text: context.watch<SendRequestController>().isApproved
                  ? 'Request Approved'
                  : context.watch<SendRequestController>().isOrderAlreadySend
                      ? "Request Sended"
                      : "Start Order",
            ),
            SizedBox(
              height: screenHeight(context) * 0.02,
            ),
            const SizedBox(),
            context.watch<SendRequestController>().isApproved
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
