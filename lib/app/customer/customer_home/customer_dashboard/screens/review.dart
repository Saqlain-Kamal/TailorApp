import 'package:flutter/material.dart';
import 'package:tailor_app/utils/mediaquery.dart';

import '../../../../../utils/colors.dart';

class Review extends StatelessWidget {
  const Review({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate your Experience'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar3.png'),
                // radius: 50,
              ),
              title: Text("name",style: const TextStyle(fontSize: 16),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star,size: 15,color: AppColors.ratingColor,),
                      const Icon(Icons.star,size: 15,color: AppColors.ratingColor,),
                      const Icon(Icons.star,size: 15,color: AppColors.ratingColor,),
                      const Icon(Icons.star,size: 15,color: AppColors.ratingColor,),
                      const Icon(Icons.star,size: 15,color: AppColors.greyColor,),
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

          ],
        ),
      ),
    );
  }
}
