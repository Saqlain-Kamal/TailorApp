import 'package:flutter/material.dart';
import 'package:tailor_app/app/extension/padding.dart';
import 'package:tailor_app/app/home/dashboard/widgets/dashboard_card.dart';
import 'package:tailor_app/app/home/dashboard/widgets/dashboard_top.dart';
import 'package:tailor_app/app/home/dashboard/widgets/recent_order_card.dart';
import 'package:tailor_app/utils/constants.dart';
import 'package:tailor_app/utils/mediaquery.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: [
            const DashboardTop(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: SizedBox(
                height: screenHeight(context) * 0.32,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.dashboard,
                      style: TextStyle(fontSize: 22),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DashboardCard(
                          asset: 'assets/images/sessor.png',
                          text: 'Orders in progress',
                        ),
                        DashboardCard(
                          text: 'Pending Orders',
                          svg: 'assets/images/clock.svg',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DashboardCard(
                          svg: 'assets/images/box.svg',
                          text: 'New Orders',
                        ),
                        DashboardCard(
                          asset: 'assets/images/review.png',
                          text: 'Reviews',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: screenWidth(context) * 0.92,
              child: const Text(
                AppStrings.recentOrders,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const RecentOrdersCard(
                      status: 'In Progress',
                    ).paddingOnly(top: 5);
                  }),
            )
          ],
        ),
      )),
    );
  }
}
