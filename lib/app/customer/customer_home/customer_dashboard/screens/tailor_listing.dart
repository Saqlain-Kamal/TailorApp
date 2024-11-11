import 'package:flutter/material.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/screens/tailor_detail.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/widgets/tailor_listing_card.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/mediaquery.dart';
import '../../../../auth/widgets/custom_text_field.dart';

class TailorListing extends StatelessWidget {
  const TailorListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(child: CustomeTextField(
                  hint: "Search for Tailors",
                  prefixIcon: 'assets/images/Search.png',
                )),
                SizedBox(width: screenWidth(context)*0.01,),
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
            SizedBox(height: screenHeight(context)*0.01,),
            const Text(
              "Tailors Listings",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: screenHeight(context)*0.01,),
            Flexible(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 1.2,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TailorDetail(),
                        ),
                      );
                    },
                    child: const TailorListingCard(
                      name: "Ali Tailor Shop",
                      cityName: "Peshawar",
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: screenHeight(context)*0.01,),
          ],
        ),
      ),
    );
  }
}
