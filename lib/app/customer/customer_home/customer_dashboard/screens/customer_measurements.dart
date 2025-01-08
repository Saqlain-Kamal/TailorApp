import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/screens/add_customer_measurements.dart';
import 'package:tailor_app/app/model/measurment_model.dart';
import 'package:tailor_app/app/utils/colors.dart';

class CustomerMeasurements extends StatefulWidget {
  const CustomerMeasurements({super.key});

  @override
  State<CustomerMeasurements> createState() => _CustomerMeasurementsState();
}

class _CustomerMeasurementsState extends State<CustomerMeasurements> {
  List<Map<String, dynamic>> home = [
    {
      'label': 'HOME',
      'address': '2464 Royal Ln. Mesa, New Jersey 45463',
    },
    {
      'label': 'OFFICE',
      'address': '3891 Ranchview Dr. Richardson, California 62639',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddMeasurements(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: AppColors.darkBlueColor,
                ),
              ),
            )
          ],
          title: const Text('Address'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('measurments')
              .doc(context.read<AuthCubit>().appUser!.id)
              .collection('measurement')
              .snapshots(),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs
                .map((e) => MeasurmentModel.fromJson(e.data()))
                .toList();
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text(
                  'Error: ${snapshot.error}'); // Handle errors appropriately
            } else if (!snapshot.hasData || data!.isEmpty) {
              return const Center(
                child: Text(
                  'No Measurements',
                  style: TextStyle(color: Colors.black),
                ),
              );
            }
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final data1 = data[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      tileColor: AppColors.lightWightColor,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: data1.label == 'Shalwar Kameez'
                            ? Image.asset(
                                'assets/images/kurta.png',
                                color: AppColors.darkBlueColor,
                              )
                            : Image.asset(
                                'assets/images/shirt.png',
                                height: 40,
                                color: AppColors.purpleColor,
                              ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data1.label,
                            style: const TextStyle(fontSize: 16),
                          ),
                          GestureDetector(
                              onTap: () {
                                // showDialog(
                                //   context: context,
                                //   builder: (context) {
                                //     return AlertDialog(
                                //       actionsPadding: const EdgeInsets.all(20),
                                //       content: const Text('Are you sure? '),
                                //       actions: [
                                //         ElevatedButton(
                                //           onPressed: () async {
                                //             Navigator.of(context).pop();
                                //             await context
                                //                 .read<MeasurmentCubit>()
                                //                 .deleteAddress(address: data1);
                                //           },
                                //           child: const Text('Delete'),
                                //         ),
                                //       ],
                                //     );
                                //   },
                                // );
                              },
                              child: Image.asset(
                                'assets/images/Delete icon.png',
                                height: 20,
                              )),
                        ],
                      ),
                      subtitle: Text(
                        data1.name,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                });
          },
        ));
  }
}
