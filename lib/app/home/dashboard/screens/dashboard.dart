import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/cubit/send_request_cubit/send_request_cubit.dart';
import 'package:tailor_app/app/extension/padding.dart';
import 'package:tailor_app/app/home/dashboard/screens/completed_orders.dart';
import 'package:tailor_app/app/home/dashboard/screens/reviews.dart';
import 'package:tailor_app/app/home/dashboard/widgets/dashboard_card.dart';
import 'package:tailor_app/app/home/dashboard/widgets/dashboard_top.dart';
import 'package:tailor_app/app/home/dashboard/widgets/recent_order_card.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/constants.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.onCardTap});
  final Function(int) onCardTap;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    getOrdersLength();
    super.initState();
  }

  void getOrdersLength() async {
    await context
        .read<SendRequestCubit>()
        .getNewOrdersLength(uid: context.read<AuthCubit>().appUser!.id!);
    await context
        .read<SendRequestCubit>()
        .getPendingOrdersLength(uid: context.read<AuthCubit>().appUser!.id!);
    await context
        .read<SendRequestCubit>()
        .getProgressOrdersLength(uid: context.read<AuthCubit>().appUser!.id!);
    await context
        .read<SendRequestCubit>()
        .getCompletedOrdersLength(uid: context.read<AuthCubit>().appUser!.id!);
    await context
        .read<SendRequestCubit>()
        .getTailorReviewLength(uid: context.read<AuthCubit>().appUser!.id!);
  }

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
          child: SingleChildScrollView(
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
                          style: TextStyle(fontSize: 23),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DashboardCard(
                              count: context
                                  .watch<SendRequestCubit>()
                                  .progressOrderLength
                                  .toString(),
                              asset: 'assets/images/sessor.png',
                              text: 'Orders in progress',
                              onTap: () {
                                widget.onCardTap(1);
                              },
                            ),
                            DashboardCard(
                              count: context
                                  .watch<SendRequestCubit>()
                                  .pendingOrderLength
                                  .toString(),
                              text: 'Pending Orders',
                              svg: 'assets/images/clock.svg',
                              onTap: () {
                                widget.onCardTap(2);
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DashboardCard(
                              count: context
                                  .watch<SendRequestCubit>()
                                  .newOrderLength
                                  .toString(),
                              svg: 'assets/images/box.svg',
                              text: 'New Orders',
                              onTap: () {
                                widget.onCardTap(0);
                              },
                            ),
                            DashboardCard(
                              count: context
                                  .watch<SendRequestCubit>()
                                  .reviewsLength
                                  .toString(),
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
                    style: TextStyle(fontSize: 23),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: screenHeight(context) * 0.32,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return const RecentOrdersCard(
                          status: 'In Progress',
                        ).paddingOnly(top: 5);
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: screenWidth(context) * 0.92,
                  child: const Text(
                    AppStrings.completeOrders,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 23),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CompletedOrders(),
                      ),
                    );
                  },
                  child: SizedBox(
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(2, 2),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                  color: Colors.grey.shade200),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          width: screenWidth(context),
                          height: screenHeight(context) * 0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${context.watch<SendRequestCubit>().completedOrderLength.toString().padLeft(2, '0')} Orders',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w400),
                              ),
                              SvgPicture.asset('assets/images/box.svg')
                            ],
                          ),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }
}
