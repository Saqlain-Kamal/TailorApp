import 'package:flutter/material.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/utils/mediaquery.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';

class CustomerDashboard extends StatelessWidget {
  const CustomerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: screenHeight(context)*0.04,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(child: CustomeTextField(
                      hint: "Search for Tailors",
                      prefixIcon: 'assets/images/Search.png',
                    )),
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: screenHeight(context)*0.06,
                      width: screenWidth(context)*0.13,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.borderGreyColor),
                          borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.notifications),
                    )
                  ],
                ),
                const Text(
                  AppStrings.dashboard,
                  style: TextStyle(fontSize: 22),
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
