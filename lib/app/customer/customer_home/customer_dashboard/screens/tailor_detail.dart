import 'package:flutter/material.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/screens/customer_payment.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/widgets/tailor_detail_card.dart';
import 'package:tailor_app/app/extension/padding.dart';
import 'package:tailor_app/app/model/user_model.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/custom_button.dart';
import '../../../../utils/mediaquery.dart';

class TailorDetail extends StatelessWidget {
  const TailorDetail({super.key, required this.tailor});
  final UserModel tailor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          tailor.name!,
          style: const TextStyle(fontSize: 20),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.favorite_border),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight(context) * 0.02,
            ),
            const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar3.png'),
                radius: 60,
              ),
            ),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
            const Center(
              child: Text(
                "15 year experience in stitching",
                style: TextStyle(fontSize: 16, color: AppColors.greyColor),
              ),
            ),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customContainer("Custom Suit"),
                SizedBox(
                  width: screenWidth(context) * 0.015,
                ),
                customContainer("Suit Alteration"),
                SizedBox(
                  width: screenWidth(context) * 0.015,
                ),
                customContainer("Dress Tailoring"),
              ],
            ),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
            const Center(
              child: Text(
                "Starting From PKR 2000",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  size: 15,
                  color: AppColors.ratingColor,
                ),
                const Text(
                  "4.8",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: screenWidth(context) * 0.015,
                ),
                const Text(
                  "(120 Reviews)",
                  style: TextStyle(fontSize: 12, color: AppColors.greyColor),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight(context) * 0.02,
            ),
            const Text(
              "Customer Reviews",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const TailorDetailCard(
                      name: 'Ali Ahmed',
                    ).paddingOnly(bottom: 5);
                  }),
            ),
            SizedBox(
              height: screenHeight(context) * 0.02,
            ),
            CustomButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomerPayment(
                      user: tailor,
                    ),
                  ),
                );
              },
              text: "Start Order",
            ),
            SizedBox(
              height: screenHeight(context) * 0.02,
            ),
            CustomButton(
              onTap: () {},
              text: "Chat",
            ),
            SizedBox(
              height: screenHeight(context) * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  Container customContainer(String text) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(width: 1, color: AppColors.borderGreyColor),
          color: AppColors.whiteColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Text(
          text,
          style: const TextStyle(fontSize: 11, color: AppColors.greyColor),
        ),
      ),
    );
  }
}
