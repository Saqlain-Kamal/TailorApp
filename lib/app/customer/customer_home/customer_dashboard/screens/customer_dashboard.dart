import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/screens/tailor_listing.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/widgets/customer_dashboard_card.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/widgets/customer_tailor_card.dart';
import 'package:tailor_app/app/extension/padding.dart';
import 'package:tailor_app/app/home/dashboard/screens/reviews.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../auth/viewmodel/cubit/auth_cubit.dart';
import '../../../../home/dashboard/widgets/recent_order_card.dart';

class CustomerDashboard extends StatelessWidget {
  const CustomerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight(context) * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                        child: CustomeTextField(
                      hint: "Search for Tailors",
                      prefixIcon: 'assets/images/Search.png',
                    )),
                    SizedBox(
                      width: screenWidth(context) * 0.01,
                    ),
                    InkWell(
                      onTap: () async {
                        try {
                          await context.read<AuthCubit>().signOut();
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => const AuthPage()),
                          //       (Route<dynamic> route) =>
                          //   false, // Removes all previous routes
                          // );
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        height: screenHeight(context) * 0.06,
                        width: screenWidth(context) * 0.13,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: AppColors.borderGreyColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.notifications),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight(context) * 0.02,
                ),
                const Text(
                  AppStrings.dashboard,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomerDashboardCard(
                      asset: 'assets/images/listing.jpeg',
                      text: 'Tailor Listings',
                      countText: '80',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TailorListing(),
                          ),
                        );
                      },
                    ),
                    CustomerDashboardCard(
                      asset: 'assets/images/measurement.jpeg',
                      text: 'Measurements',
                      countText: '05',
                      onTap: () {},
                    ),
                    CustomerDashboardCard(
                      asset: 'assets/images/review.png',
                      text: 'Client Reviews',
                      countText: '80',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Reviews(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight(context) * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Top Rated Tailors",
                      style: TextStyle(fontSize: 20),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "View all",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight(context) * 0.02,
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight(context) * 0.15,
            child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CustomerTailorCard(
                      asset: 'assets/images/sessor.png',
                      text: 'Ahmed Tailoring',
                      rating: '4.6',
                      priceText: '1600',
                      onTap: () {},
                    ),
                  );
                }),
          ).paddingOnly(left: 15),
          SizedBox(
            height: screenHeight(context) * 0.02,
          ),
          const Text(
            "Your Orders",
            style: TextStyle(fontSize: 20),
          ).paddingSymmetric(horizontal: 15),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const RecentOrdersCard(
                    status: 'In Progress',
                    showBtn: false,
                  ).paddingOnly(bottom: 5);
                }),
          )
        ],
      ),
    );
  }
}
