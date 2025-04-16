import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/cubit/send_request_cubit/send_request_cubit.dart';
import 'package:tailor_app/app/extension/snackbar.dart';
import 'package:tailor_app/app/home/dashboard/widgets/recent_orders_button.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

class RecentOrdersCard extends StatelessWidget {
  const RecentOrdersCard({
    super.key,
    this.user,
    required this.status,
    this.showBtn = true,
    this.value,
    this.orderDate,
  });
  final String status;
  final String? orderDate;
  final bool showBtn;
  final UserModel? user;
  final int? value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: AppColors.borderGreyColor)),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar3.png'),
                radius: 30,
              ),
              title: Text(user?.name ?? 'Sarah Khan'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user?.place ?? ''),
                  Text(
                    'Delivery Date: ${orderDate ?? 'oct 15,2024'}',
                    style: const TextStyle(fontSize: 11),
                  )
                ],
              ),
              trailing: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    color: status == 'In Progress'
                        ? AppColors.blueColor
                        : status == 'Pending'
                            ? AppColors.goldenColor
                            : Colors.green,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  status.isEmpty ? 'request send' : status,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const RecentOrdersButton(
                  text: 'View Details',
                ),
                if (showBtn)
                  const SizedBox(
                    width: 25,
                  ),
                if (showBtn)
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomAlertDialogue(
                            user: user!,
                            value: value!, //index pass
                          );
                        },
                      );
                    },
                    child: const RecentOrdersButton(
                      text: 'Update Status',
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomAlertDialogue extends StatefulWidget {
  const CustomAlertDialogue({
    required this.user,
    required this.value,
    super.key,
  });
  final UserModel user;
  final int value;
  @override
  State<CustomAlertDialogue> createState() => _CustomAlertDialogueState();
}

class _CustomAlertDialogueState extends State<CustomAlertDialogue> {
  int? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
    log(selectedValue.toString()); // Initialize inside initState()
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      content: SizedBox(
        width: screenWidth(context),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Adjust size to fit content
          children: [
            widget.value == 1 || widget.value == 2
                ? const SizedBox()
                : RadioListTile<int>(
                    title: const Text('Pending'),
                    value: 3, // Unique value for this option
                    groupValue: selectedValue,
                    onChanged: (value) async {
                      setState(() {
                        selectedValue = value;
                      });
                      // try {
                      //   await context
                      //       .read<SendRequestController>()
                      //       .moveOrderToPending(
                      //           myUid: context.read<AuthController>().appUser!.id!,
                      //           otherUid: widget.user.id!);
                      // } catch (e) {
                      //   if (context.mounted) {
                      //     context.mySnackBar(
                      //         text: e.toString(), color: Colors.red);
                      //   }
                      // }

                      Navigator.pop(context);
                    },
                  ),
            widget.value == 1
                ? const SizedBox()
                : RadioListTile<int>(
                    title: const Text('In Progress'),
                    value: 2, // Unique value for this option
                    groupValue: selectedValue,

                    onChanged: (value) async {
                      log('asdasdas');
                      if (widget.value == 2) {
                        log('asdasdasdasd');
                        // If already in progress, just close the dialog
                        Navigator.pop(context);
                        return;
                      }
                      setState(() {
                        selectedValue = value;
                      });

                      try {
                        await context
                            .read<SendRequestController>()
                            .moveOrderToInProgress(
                                myUid:
                                    context.read<AuthController>().appUser!.id!,
                                otherUid: widget.user.id!);
                      } catch (e) {
                        if (context.mounted) {
                          context.mySnackBar(
                              text: e.toString(), color: Colors.red);
                        }
                      }
                      Navigator.pop(context);
                    },
                  ),
            RadioListTile<int>(
              title: const Text('Completed'),
              value: 1, // Unique value for this option
              groupValue: selectedValue,
              onChanged: (value) async {
                setState(() {
                  selectedValue = value;
                });
                log(selectedValue.toString());
                try {
                  await context
                      .read<SendRequestController>()
                      .moveOrderToCompleted(
                          myUid: context.read<AuthController>().appUser!.id!,
                          otherUid: widget.user.id!);
                } catch (e) {
                  if (context.mounted) {
                    context.mySnackBar(text: e.toString(), color: Colors.red);
                  }
                }

                Navigator.pop(context);
              },
            ),
            widget.value == 1
                ? RadioListTile<int>(
                    title: const Text('Delivered'),
                    value: 2, // Unique value for this option
                    groupValue: selectedValue,

                    onChanged: (value) async {
                      log('asdasdas');
                      if (widget.value == 2) {
                        log('asdasdasdasd');
                        // If already in progress, just close the dialog
                        Navigator.pop(context);
                        return;
                      }
                      setState(() {
                        selectedValue = value;
                      });

                      try {
                        await context
                            .read<SendRequestController>()
                            .moveOrderToDelivered(
                                myUid:
                                    context.read<AuthController>().appUser!.id!,
                                otherUid: widget.user.id!);
                      } catch (e) {
                        if (context.mounted) {
                          context.mySnackBar(
                              text: e.toString(), color: Colors.red);
                        }
                      }
                      Navigator.pop(context);
                    },
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
