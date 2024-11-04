import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/extension/padding.dart';
import 'package:tailor_app/app/home/dashboard/screens/reviews.dart';
import 'package:tailor_app/app/home/dashboard/widgets/dashboard_card.dart';
import 'package:tailor_app/app/home/dashboard/widgets/dashboard_top.dart';
import 'package:tailor_app/app/home/dashboard/widgets/recent_order_card.dart';
import 'package:tailor_app/utils/colors.dart';
import 'package:tailor_app/utils/constants.dart';
import 'package:tailor_app/utils/mediaquery.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key, required this.onCardTap});
  final Function(int) onCardTap;
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().appUser;
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: AppColors.darkBlueColor,
    // ));

    return Scaffold(
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
                user: user!,
              ).paddingOnly(top: 50),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              // const DashboardTop(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: SizedBox(
                  height: screenHeight(context) * 0.32,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        AppStrings.dashboard,
                        style: TextStyle(fontSize: 22),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DashboardCard(
                            asset: 'assets/images/sessor.png',
                            text: 'Orders in progress',
                            onTap: () {
                              onCardTap(1);
                            },
                          ),
                          DashboardCard(
                            text: 'Pending Orders',
                            svg: 'assets/images/clock.svg',
                            onTap: () {
                              onCardTap(2);
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DashboardCard(
                            svg: 'assets/images/box.svg',
                            text: 'New Orders',
                            onTap: () {
                              onCardTap(0);
                            },
                          ),
                          DashboardCard(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Reviews(),
                                ),
                              );
                            },
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
        ));
  }
}
