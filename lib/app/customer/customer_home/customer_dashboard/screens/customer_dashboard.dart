import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/cubit/measurment_cubit/measurment_cubit.dart';
import 'package:tailor_app/app/cubit/tailor_cubits/cubits/tailor_cubit.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/screens/customer_measurements.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/screens/tailor_detail.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/screens/tailor_listing.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/widgets/customer_dashboard_card.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/widgets/customer_tailor_card.dart';
import 'package:tailor_app/app/extension/padding.dart';
import 'package:tailor_app/app/home/dashboard/screens/reviews.dart';
import 'package:tailor_app/app/home/orders/screens/order_summary.dart';
import 'package:tailor_app/app/model/measurment_model.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

import '../../../../auth/viewmodel/cubit/auth_cubit.dart';
import '../../../../home/dashboard/widgets/recent_order_card.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        getTailors();
      },
    );

    super.initState();
  }

  void getTailors() async {
    await context.read<TailorController>().getTailors();
    await context
        .read<MeasurmentController>()
        .getMeasurments(uid: context.read<AuthController>().appUser!.id!);
    // context
    //     .read<FavoriteCubit>()
    //     .fetchFavorites(uid: context.read<AuthController>().appUser!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
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
                            await context.read<AuthController>().signOut();
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
                        text: 'Tailor Listing',
                        countText: context
                            .watch<TailorController>()
                            .tailorList
                            .length
                            .toString(),
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
                        countText: context
                            .watch<MeasurmentController>()
                            .measurementsList
                            .length
                            .toString(),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CustomerMeasurements(),
                            ),
                          );
                        },
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
            const TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: AppColors.darkBlueColor,
                indicatorColor: AppColors.darkBlueColor,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(
                    child: Text('Ongoing Orders'),
                  ),
                  Tab(
                    child: Text('History Orders'),
                  ),
                ]),
            Expanded(
              child: TabBarView(children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(context.read<AuthController>().appUser!.id)
                        .collection('sentOrders')
                        .where('status', isEqualTo: 'Approved')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Text('data');
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('NO ORDERS'));
                      }
                      final data = snapshot.data!.docs.map((e) {
                        final orderData = e.data();

                        return {
                          'user': UserModel.fromJson(
                            orderData['user'],
                          ),
                          'docId': orderData['docId'],
                          'timestamp': orderData['timestamp'],
                          'orderId': orderData['orderId'],
                          'orderStatus': orderData['orderStatus'],
                          'deliveryDate': orderData['deliveryDate'],
                          'measurements': (orderData['measurements'] != null &&
                                  orderData['measurements'].isNotEmpty)
                              ? MeasurmentModel.fromJson(
                                  orderData['measurements'])
                              : null,
                        };
                      }).toList();
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final user = data[index]['user'] as UserModel;
                            final docId = data[index]['docId'].toString();
                            final deliveryDate = data[index]['deliveryDate'];
                            final date = data[index]['timestamp'] as Timestamp;
                            final dateTime = date.toDate();
                            final formattedDate =
                                DateFormat('dd MMMM yyyy').format(dateTime);
                            final orderId = data[index]['orderId'].toString();
                            final status =
                                data[index]['orderStatus'].toString();
                            final measurements =
                                data[index]['measurements'] as MeasurmentModel?;
                            log(status.toString());
                            return GestureDetector(
                              onTap: () {
                                log('message');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TailorDetail(
                                      tailor: user,
                                    ),
                                  ),
                                );
                              },
                              child: RecentOrdersCard(
                                orderDate: deliveryDate,
                                user: user,
                                status: status,
                                showBtn: false,
                              ).paddingOnly(bottom: 5),
                            );
                          });
                    }),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(context.read<AuthController>().appUser!.id)
                        .collection('historyOrders')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Text('data');
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('NO ORDERS'));
                      }
                      final data = snapshot.data!.docs.map((e) {
                        final orderData = e.data();

                        return {
                          'user': UserModel.fromJson(
                            orderData['user'],
                          ),
                          'docId': orderData['docId'],
                          'timestamp': orderData['timestamp'],
                          'isShowReviewDialogue':
                              orderData['isShowReviewDialogue'],
                          'orderId': orderData['orderId'],
                          'orderStatus': orderData['orderStatus'],
                          'deliveryDate': orderData['deliveryDate'],
                          'measurements': (orderData['measurements'] != null &&
                                  orderData['measurements'].isNotEmpty)
                              ? MeasurmentModel.fromJson(
                                  orderData['measurements'])
                              : null,
                        };
                      }).toList();
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final user = data[index]['user'] as UserModel;
                            final docId = data[index]['docId'].toString();
                            final deliveryDate =
                                data[index]['deliveryDate'].toString();
                            final date = data[index]['timestamp'] as Timestamp;
                            final isShowReviewDialogue =
                                data[index]['isShowReviewDialogue'];
                            final dateTime = date.toDate();
                            final formattedDate =
                                DateFormat('dd MMMM yyyy').format(dateTime);
                            final orderId = data[index]['orderId'].toString();
                            final status =
                                data[index]['orderStatus'].toString();
                            final measurements =
                                data[index]['measurements'] as MeasurmentModel?;
                            log(status.toString());
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderSummary(
                                      status: status,
                                      deliveryDate: deliveryDate,
                                      measurmentModel: measurements,
                                      user: user,
                                      docId: docId,
                                      orderId: orderId,
                                      date: formattedDate,
                                      isShowReviewDialogue:
                                          isShowReviewDialogue,
                                    ),
                                  ),
                                );
                              },
                              child: RecentOrdersCard(
                                orderDate: formattedDate,
                                user: user,
                                status: status,
                                showBtn: false,
                              ).paddingOnly(bottom: 5),
                            );
                          });
                    })
              ]),
            )
          ],
        ),
      ),
    );
  }
}
