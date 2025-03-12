import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/extension/padding.dart';
import 'package:tailor_app/app/home/dashboard/widgets/recent_order_card.dart';
import 'package:tailor_app/app/home/orders/screens/new_orders.dart';
import 'package:tailor_app/app/home/orders/screens/order_summary.dart';
import 'package:tailor_app/app/model/measurment_model.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/utils/colors.dart';

class Orders extends StatefulWidget {
  const Orders({super.key, this.initialIndex = 0});
  final int initialIndex;
  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final ValueNotifier<String> _appBarTitleNotifier =
      ValueNotifier<String>('New Orders');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
    _updateTitle(widget.initialIndex);

    // Listen to tab changes and update the title
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _updateTitle(_tabController.index);
      }
    });
  }

  void _updateTitle(int index) {
    switch (index) {
      case 0:
        _appBarTitleNotifier.value = 'New Orders';
        break;
      case 1:
        _appBarTitleNotifier.value = 'In Progress';
        break;
      case 2:
        _appBarTitleNotifier.value = 'Pending';
        break;
      default:
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            title: ValueListenableBuilder(
          valueListenable: _appBarTitleNotifier,
          builder: (context, value, child) {
            return Text(value);
          },
        )),
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: AppColors.darkBlueColor,
              indicatorColor: AppColors.darkBlueColor,
              dividerColor: Colors.transparent,
              splashBorderRadius: BorderRadius.circular(12),
              tabs: const [
                Tab(child: Text('New Orders')),
                Tab(child: Text('In Progress')),
                Tab(child: Text('Pending')),
              ],
            ).paddingSymmetric(horizontal: 15),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(context.read<AuthCubit>().appUser!.id)
                        .collection('receiveOrders')
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
                      log('hiii');

                      final data = snapshot.data!.docs.map((e) {
                        final orderData = e.data();
                        return {
                          'user': UserModel.fromJson(
                            orderData['user'],
                          ),
                          'measurements': (orderData['measurements'] != null &&
                                  orderData['measurements'].isNotEmpty)
                              ? MeasurmentModel.fromJson(
                                  orderData['measurements'])
                              : null,
                          'docId': orderData['docId'],
                          'timestamp': orderData['timestamp'],
                          'deliveryDate': orderData['deliveryDate'],
                          'orderId': orderData['orderId'],
                        };
                      }).toList();

                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final user = data[index]['user'];
                          final measurements = data[index]['measurements'];
                          final docId = data[index]['docId'].toString();
                          final date = data[index]['timestamp'];
                          final deliveryDate = data[index]['deliveryDate'];

                          final dateTime = date.toDate();
                          final formattedDate =
                              DateFormat('dd MMMM yyyy').format(dateTime);
                          final orderId = data[index]['orderId'].toString();

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewOrders(
                                    measurmentModel: measurements,
                                    deliveryDate: deliveryDate,
                                    user: user,
                                    docId: docId,
                                    orderId: orderId,
                                    date: formattedDate,
                                  ),
                                ),
                              );
                            },
                            child: RecentOrdersCard(
                              value: 1,
                              user: user,
                              status: 'New',
                              showBtn: false,
                            ).paddingOnly(top: 2, bottom: 3),
                          );
                        },
                      );
                    },
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(context.read<AuthCubit>().appUser!.id)
                          .collection('inProgressOrders')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Text('data');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('NO ORDERS'));
                        }
                        final data = snapshot.data!.docs.map((e) {
                          final orderData = e.data();
                          return {
                            'user': UserModel.fromJson(orderData['user']),
                            'docId': orderData['docId'],
                            'timetamp': orderData['timestamp'],
                            'orderId': orderData['orderId'],
                            'measurements':
                                (orderData['measurements'] != null &&
                                        orderData['measurements'].isNotEmpty)
                                    ? MeasurmentModel.fromJson(
                                        orderData['measurements'])
                                    : null,
                            'deliveryDate': orderData['deliveryDate'],
                            'orderStatus': orderData['orderStatus'],
                          };
                        }).toList();
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final user = data[index]['user'];
                            final measurements = data[index]['measurements'];
                            final deliveryDate = data[index]['deliveryDate'];
                            final orderStatus = data[index]['orderStatus'];

                            final date = data[index]['timetamp'];
                            final dateTime = date.toDate();
                            final formattedDate =
                                DateFormat('dd MMMM yyyy').format(dateTime);
                            final docId = data[index]['docId'].toString();
                            final orderId = data[index]['orderId'].toString();
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderSummary(
                                      status: orderStatus,
                                      deliveryDate: deliveryDate,
                                      measurmentModel: measurements,
                                      user: user,
                                      docId: docId,
                                      orderId: orderId,
                                      date: formattedDate,
                                    ),
                                  ),
                                );
                              },
                              child: RecentOrdersCard(
                                value: 2,
                                user: user,
                                status: 'In Progress',
                              ).paddingOnly(top: 2, bottom: 3),
                            );
                          },
                        );
                      }),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(context.read<AuthCubit>().appUser!.id)
                          .collection('pendingOrders')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Text('data');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('NO ORDERS'));
                        }
                        final data = snapshot.data!.docs.map((e) {
                          final orderData = e.data();
                          return {
                            'user': UserModel.fromJson(orderData['user']),
                            'docId': orderData['docId'],
                            'timestamp': orderData['timestamp'],
                            'orderId': orderData['orderId'],
                            'measurements':
                                (orderData['measurements'] != null &&
                                        orderData['measurements'].isNotEmpty)
                                    ? MeasurmentModel.fromJson(
                                        orderData['measurements'])
                                    : null,
                            'deliveryDate': orderData['deliveryDate'],
                            'orderStatus': orderData['orderStatus'],
                          };
                        }).toList();
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final user = data[index]['user'];
                            final measurements = data[index]['measurements'];
                            final deliveryDate = data[index]['deliveryDate'];
                            final orderStatus = data[index]['orderStatus'];

                            final date = data[index]['timestamp'];
                            final dateTime = date.toDate();
                            final formattedDate =
                                DateFormat('dd MMMM yyyy').format(dateTime);
                            final docId = data[index]['docId'].toString();
                            final orderId = data[index]['orderId'].toString();
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderSummary(
                                      status: orderStatus,
                                      deliveryDate: deliveryDate,
                                      measurmentModel: measurements,
                                      user: user,
                                      docId: docId,
                                      orderId: orderId,
                                      date: formattedDate,
                                    ),
                                  ),
                                );
                              },
                              child: RecentOrdersCard(
                                value: 3,
                                user: user,
                                status: 'Pending',
                              ).paddingOnly(top: 2, bottom: 3),
                            );
                          },
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
