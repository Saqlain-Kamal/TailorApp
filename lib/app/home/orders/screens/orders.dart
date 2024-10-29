import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tailor_app/app/extension/padding.dart';
import 'package:tailor_app/app/home/dashboard/widgets/recent_order_card.dart';
import 'package:tailor_app/utils/colors.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  String _appBarTitle = 'New Orders';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Listen to tab changes and update the title
    _tabController.addListener(() {
      setState(() {
        log('message');
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
          title: Text(
            _appBarTitle,
          ),
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
                Tab(
                  child: Text('New Orders'),
                ),
                Tab(
                  child: Text('In Progress'),
                ),
                Tab(
                  child: Text('Pending '),
                ),
              ],
            ).paddingSymmetric(horizontal: 15),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const RecentOrdersCard(
                      status: 'New',
                    ).paddingOnly(top: 2, bottom: 3);
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
              ]),
            )
          ],
        ),
      ),
    );
  }
}
