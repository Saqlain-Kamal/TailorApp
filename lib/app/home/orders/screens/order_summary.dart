import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/constants.dart';
import 'package:tailor_app/app/utils/container_decoration.dart';
import 'package:tailor_app/app/utils/custom_button.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary(
      {super.key,
      required this.user,
      required this.orderId,
      required this.docId,
      required this.date});
  final UserModel user;
  final String orderId;
  final String docId;
  final String date;

  @override
  Widget build(BuildContext context) {
    const LatLng loc = LatLng(37.4223, -10.0848);
    log(context.read<AuthCubit>().currentPosition.toString());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/avatar3.png'),
                ),
                title: Text(user.name!),
                subtitle: Text(user.email!),
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
                          orderId,
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
                          date,
                          style: const TextStyle(fontSize: 12),
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
                          date,
                          style: const TextStyle(fontSize: 12),
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
                        target: user.lat != null
                            ? LatLng(double.tryParse(user.lat!)!,
                                double.tryParse(user.lon!)!)
                            : loc,
                        zoom: 10),
                    markers: {
                      Marker(
                        markerId: const MarkerId('value'),
                        icon: BitmapDescriptor.defaultMarker,
                        position: user.lat != null
                            ? LatLng(double.tryParse(user.lat!)!,
                                double.tryParse(user.lon!)!)
                            : loc,
                      )
                    },
                  ),
                ),
              ),
              const Spacer(),
              CustomButton(
                onTap: () {},
                text: "Chat",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
