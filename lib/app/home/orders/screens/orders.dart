import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/extension/padding.dart';
import 'package:tailor_app/app/home/dashboard/widgets/recent_order_card.dart';
import 'package:tailor_app/app/home/orders/screens/new_orders.dart';
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

  String _appBarTitle = 'New Orders';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialIndex,
    );

    // Listen to tab changes and update the title
    _tabController.addListener(() {
      setState(() {
        switch (_tabController.index) {
          case 0:
            _appBarTitle = 'New Orders';
            break;
          case 1:
            _appBarTitle = 'In Progress';
            break;
          case 2:
            _appBarTitle = 'Pending';
            break;
        }
      });
    });
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
          title: Text(_appBarTitle),
        ),
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
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
                          'docId': orderData['docId'],
                          'timetamp': orderData['timestamp'],
                          'orderId': orderData['orderId'],
                        };
                      }).toList();

                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final user = data[index]['user'];
                          final docId = data[index]['docId'].toString();
                          final orderId = data[index]['orderId'].toString();

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewOrders(
                                    user: user,
                                    docId: docId,
                                    orderId: orderId,
                                  ),
                                ),
                              );
                            },
                            child: RecentOrdersCard(
                              user: user,
                              status: 'New',
                            ).paddingOnly(top: 2, bottom: 3),
                          );
                        },
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const RecentOrdersCard(
                        status: 'In Progress',
                      ).paddingOnly(top: 2, bottom: 3);
                    },
                  ),
                  ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const RecentOrdersCard(
                        status: 'Pending',
                      ).paddingOnly(top: 2, bottom: 3);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
