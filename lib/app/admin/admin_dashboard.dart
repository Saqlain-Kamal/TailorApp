import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tailor_app/app/auth/screens/auth_page.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/widgets/drop_down_type.dart';
import 'package:tailor_app/app/cubit/send_request_cubit/send_request_cubit.dart';
import 'package:tailor_app/app/home/dashboard/widgets/recent_orders_button.dart';
import 'package:tailor_app/app/model/measurment_model.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key, required this.userEmail});
  final String userEmail;

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int? selectedIndex; // Track selected row index
  String formattedDate =
      DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  List<Map<String, dynamic>> userData = [
    {
      'name': 'Saqlain Kamal',
      'email': 'kamal@gmail.com',
      'date': DateFormat('dd-MMM-yyyy HH:mm:ss')
          .format(DateTime.now().subtract(const Duration(minutes: 10))),
      'status': 'Pending',
    },
    {
      'name': 'Nisma Khan',
      'email': 'nisma@gmail.com',
      'date': DateFormat('dd-MMM-yyyy HH:mm:ss').format(DateTime.now()),
      'status': 'Pending',
    },
  ];
  final ValueNotifier<int?> selectedIndexNotifier = ValueNotifier<int?>(null);
  String? value;
  @override
  Widget build(BuildContext context) {
    log(DateTime.now().toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('A D M I N ${widget.userEmail}'),
        actions: [
          InkWell(
            onTap: () async {
              try {
                await context
                    .read<AuthController>()
                    .signOut()
                    .then((onValue) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AuthPage()),
                          (Route<dynamic> route) =>
                              false, // Removes all previous routes
                        ));
              } catch (e) {
                log(e.toString());
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              height: screenHeight(context) * 0.06,
              width: screenWidth(context) * 0.13,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.borderGreyColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.notifications),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('ordersToAdmin')
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
                  'status': orderData['status'],
                  'tailorId': orderData['tailorId'],
                  'CustomerId':
                      orderData['CustomerId'] ?? '3lMy6rxAI0fmAGXGsV08uHNHrGA2',
                };
              }).toList();
              return ValueListenableBuilder(
                  valueListenable: selectedIndexNotifier,
                  builder: (context, selectedIndex, child) {
                    return DataTable(
                      dataRowHeight: 62,
                      showCheckboxColumn: false,
                      sortColumnIndex: 2,
                      sortAscending: true,
                      columns: const [
                        DataColumn(label: Text('UID')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Date/Time'), numeric: true),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: List.generate(data.length, (index) {
                        // final user = userData[index];
                        final user = data[index]['user'] as UserModel;
                        final measurements = data[index]['measurements'];
                        final deliveryDate = data[index]['deliveryDate'];
                        var status = data[index]['status'];
                        var tailorId = data[index]['tailorId'];
                        var customerId = data[index]['CustomerId'] ??
                            '3lMy6rxAI0fmAGXGsV08uHNHrGA2';

                        final date = data[index]['timetamp'];
                        final dateTime = date.toDate();
                        final formattedDate =
                            DateFormat('dd MMMM yyyy').format(dateTime);
                        final docId = data[index]['docId'].toString();
                        final orderId = data[index]['orderId'].toString();
                        return DataRow(
                          selected:
                              selectedIndex == index, // Highlight selected row
                          onSelectChanged: (isSelected) {
                            selectedIndexNotifier.value =
                                isSelected! ? index : null;
                          },
                          cells: [
                            DataCell(Text(user.id!)),
                            DataCell(Text(user.name!)),
                            DataCell(Text(user.email!)),
                            DataCell(Text(formattedDate.toString())),
                            DataCell(
                              // Container(
                              //   padding: const EdgeInsets.all(8),
                              //   width: 80,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(12),
                              //     gradient: const LinearGradient(colors: [
                              //       AppColors.darkBlueColor,
                              //       AppColors.blueColor
                              //     ]),
                              //     border: Border.all(
                              //         width: 1, color: AppColors.borderGreyColor),
                              //   ),
                              //   child: const Text(
                              //     'Status',
                              //     textAlign: TextAlign.center,
                              //     style: TextStyle(fontSize: 14, color: Colors.white),
                              //   ),
                              // ),
                              status == 'Approved'
                                  ? Container(
                                      padding: const EdgeInsets.all(8),
                                      width: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.green,
                                        border: Border.all(
                                            width: 1,
                                            color: AppColors.borderGreyColor),
                                      ),
                                      child: const Text(
                                        'Approved',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    )
                                  : Container(
                                      child: DropdownButton<String>(
                                        value: status,
                                        hint: const Text('choose'),
                                        onChanged: (newValue) async {
                                          setState(() {
                                            status = newValue;
                                          });
                                          if (status == 'Approved') {
                                            try {
                                              await context
                                                  .read<SendRequestController>()
                                                  .acceptOrder(
                                                      myUid: tailorId,
                                                      otherUid: customerId,
                                                      orderId: orderId);
                                            } catch (e) {
                                              log(e.toString());
                                            }
                                          }
                                        },
                                        items: [
                                          'pending',
                                          'Approved',
                                          'Rejected'
                                        ].map((status) {
                                          return DropdownMenuItem<String>(
                                            value: status,
                                            child: Text(status),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                            ),
                          ],
                        );
                      }),
                    );
                  });
            }),
      ),
    );
  }
}

// Dummy Data for Users
