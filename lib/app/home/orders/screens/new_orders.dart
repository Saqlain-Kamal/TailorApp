import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/cubit/send_request_cubit/send_request_cubit.dart';
import 'package:tailor_app/app/cubit/send_request_cubit/send_request_states.dart';
import 'package:tailor_app/app/extension/snackbar.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/constants.dart';
import 'package:tailor_app/app/utils/container_decoration.dart';
import 'package:tailor_app/app/utils/custom_button.dart';

class NewOrders extends StatelessWidget {
  const NewOrders({
    super.key,
    required this.user,
    required this.orderId,
    required this.docId,
  });
  final UserModel user;
  final String orderId;
  final String docId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/avatar3.png'),
                ),
                title: Text(user.name!),
                subtitle: Text(user.location!),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                AppStrings.orderSummary,
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: reusableBoxDecoration,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.orderId,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        Text(
                          orderId,
                        ),
                      ],
                    ),
                    const Divider(
                      color: AppColors.borderGreyColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.orderDate,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        const Text(
                          '01/10/24',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.price,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        const Text(
                          '2000',
                        ),
                      ],
                    ),
                    const Divider(
                      color: AppColors.borderGreyColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.deliveryDate,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        const Text(
                          '15/10/24',
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: BlocConsumer<SendRequestCubit, SendRequestStates>(
                      listener: (context, state) {
                        if (state is RequestAcceptedStates) {
                          log('ji');
                          context.mySnackBar(
                              text: 'Order Accepted',
                              color: AppColors.darkBlueColor);
                        }
                        if (state is OrderNotFoundState) {
                          log('ji');
                          context.mySnackBar(
                              text: 'Order Not Found', color: Colors.red);
                        }
                        if (state is ErrorState) {
                          log('here');
                          context.mySnackBar(
                              text: state.message, color: Colors.red);
                        }
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if (state is LoadingStates) {
                          return CustomButton(
                            onTap: () {},
                            text: 'text',
                            isloading: true,
                            firstColor: Colors.green.shade600,
                            secondColor: Colors.green.shade600,
                          );
                        }
                        // if (state is RequestSendedStates) {
                        //   WidgetsBinding.instance.addPostFrameCallback((_) {
                        //     Navigator.popUntil(context, (route) => route.isFirst);
                        //   });
                        // }

                        return CustomButton(
                          onTap: () async {
                            try {
                              await context
                                  .read<SendRequestCubit>()
                                  .acceptOrder(
                                      myUid: context
                                          .read<AuthCubit>()
                                          .appUser!
                                          .id!,
                                      otherUid: user.id!);
                            } catch (e) {
                              if (context.mounted) {
                                context.mySnackBar(
                                    text: e.toString(), color: Colors.red);
                              }
                            }

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => CustomerPayment(
                            //       user: tailor,
                            //     ),
                            //   ),
                            // );
                          },
                          text: 'ACCEPT',
                          firstColor: Colors.green.shade600,
                          secondColor: Colors.green.shade600,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomButton(
                      onTap: () {},
                      text: 'REJECT',
                      firstColor: Colors.red,
                      secondColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
