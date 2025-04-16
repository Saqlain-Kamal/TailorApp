import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/extension/padding.dart';
import 'package:tailor_app/app/home/dashboard/widgets/recent_order_card.dart';
import 'package:tailor_app/app/home/orders/screens/order_summary.dart';
import 'package:tailor_app/app/model/measurment_model.dart';
import 'package:tailor_app/app/model/user_model.dart';

class CompletedOrders extends StatelessWidget {
  const CompletedOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Orders'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(context.read<AuthController>().appUser!.id)
              .collection('completeOrders')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text('data');
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('NO ORDERS'));
            }
            final data = snapshot.data!.docs.map((e) {
              final orderData = e.data();
              return {
                'user': UserModel.fromJson(orderData['user']),
                'docId': orderData['docId'],
                'timetamp': orderData['timestamp'],
                'orderId': orderData['orderId'],
                'measurements': (orderData['measurements'] != null &&
                        orderData['measurements'].isNotEmpty)
                    ? MeasurmentModel.fromJson(orderData['measurements'])
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

                final date = data[index]['timetamp'];
                final dateTime = date.toDate();
                final formattedDate =
                    DateFormat('dd MMMM yyyy').format(dateTime);
                final docId = data[index]['docId'].toString();
                final orderId = data[index]['orderId'].toString();
                final orderStatus = data[index]['orderStatus'].toString();
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
                    value: 1,
                    user: user,
                    status: orderStatus,
                    showBtn: orderStatus == 'Delivered' ? false : true,
                  ).paddingOnly(top: 2, bottom: 3),
                );
              },
            );
          }),
    );
  }
}
