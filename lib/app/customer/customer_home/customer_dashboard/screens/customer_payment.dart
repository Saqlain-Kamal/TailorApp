import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/screens/review.dart';
import 'package:tailor_app/app/model/user_model.dart';

import '../../../../home/profile/widgets/custom_alert_dialogue.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/custom_button.dart';
import '../../../../utils/mediaquery.dart';

class CustomerPayment extends StatefulWidget {
  const CustomerPayment({super.key, required this.user});
  final UserModel user;
  @override
  State<CustomerPayment> createState() => _CustomerPaymentState();
}

class _CustomerPaymentState extends State<CustomerPayment> {
  int selectedContainer = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment Method',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight(context) * 0.02,
            ),
            customContainer(context, "Easypaisa", () {
              setState(() {
                selectedContainer = 0;
              });
            }, 0),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
            customContainer(context, "Wallet", () {
              setState(() {
                selectedContainer = 1;
              });
            }, 1),
            const Spacer(),
            CustomButton(
              text: "Pay Now",
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return CustomAlertDialogue(
                      image: 'assets/images/warning.png',
                      title: 'Your order has been placed successfully',
                      desc:
                          "Thank you for choosing us. We'll notify you when your order is ready",
                      showBtn1: false,
                      btnText2: 'Leave Review',
                      btnOnTap2: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Review(
                              user: widget.user,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
            SizedBox(
              height: screenHeight(context) * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector customContainer(
      BuildContext context, String text, void Function() onTap, int index) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth(context) * 0.9,
        height: screenHeight(context) * 0.07,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: GradientBoxBorder(
              gradient: LinearGradient(
                colors: [
                  index == selectedContainer
                      ? AppColors.darkBlueColor
                      : AppColors.borderGreyColor,
                  index == selectedContainer
                      ? AppColors.lightkBlueColor
                      : AppColors.borderGreyColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
            color: AppColors.whiteColor),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
