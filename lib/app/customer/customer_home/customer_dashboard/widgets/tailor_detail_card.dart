import 'package:flutter/material.dart';
import 'package:tailor_app/app/home/dashboard/widgets/recent_orders_button.dart';
import 'package:tailor_app/utils/colors.dart';

import '../../../../../utils/mediaquery.dart';

class TailorDetailCard extends StatelessWidget {
  const TailorDetailCard({
    super.key,
    required this.name,
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: AppColors.borderGreyColor)),
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar3.png'),
              radius: 20,
            ),
            title: Text(name,style: const TextStyle(fontSize: 16),),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.star,size: 15,color: AppColors.ratingColor,),
                    Icon(Icons.star,size: 15,color: AppColors.ratingColor,),
                    Icon(Icons.star,size: 15,color: AppColors.ratingColor,),
                    Icon(Icons.star,size: 15,color: AppColors.ratingColor,),
                    Icon(Icons.star,size: 15,color: AppColors.greyColor,),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.watch_later_outlined,size: 14,),
                    SizedBox(width: 5,),
                    Text("Apr 22,2024",style: const TextStyle(fontSize: 10,color: AppColors.greyColor),),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text("Great Service! My dress was ready on time, and the stitching was flawless.",style: TextStyle(fontSize: 12,color: AppColors.greyColor)),
        ],
      ),
    );
  }
}
