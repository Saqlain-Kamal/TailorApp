import 'package:flutter/material.dart';
import 'package:tailor_app/app/home/dashboard/widgets/recent_orders_button.dart';
import 'package:tailor_app/utils/colors.dart';

import '../../../../../utils/mediaquery.dart';

class TailorListingCard extends StatelessWidget {
  const TailorListingCard({
    super.key,
    required this.name,
    required this.cityName,
  });
  final String name;
  final String cityName;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context) * 0.34,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: AppColors.borderGreyColor)),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar3.png'),
              radius: 20,
            ),
            title: Text(name,style: const TextStyle(fontSize: 12),),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on_outlined,size: 15,),
                Text(cityName,style: const TextStyle(fontSize: 12),)
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Row(
            children: [
              Icon(Icons.star,size: 15,color: AppColors.ratingColor,),
              Icon(Icons.star,size: 15,color: AppColors.ratingColor,),
              Icon(Icons.star,size: 15,color: AppColors.ratingColor,),
              Icon(Icons.star,size: 15,color: AppColors.ratingColor,),
              Icon(Icons.star,size: 15,color: AppColors.greyColor,),
            ],
          ),
          const Text("PKR 2000 - 8000",style: TextStyle(fontSize: 12)),
          const Text("Custom Stitching",style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
