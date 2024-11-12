import 'package:flutter/material.dart';
import 'package:tailor_app/utils/border_custom_button.dart';
import 'package:tailor_app/utils/custom_button.dart';
import 'package:tailor_app/utils/mediaquery.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import '../../../../../utils/colors.dart';

class Review extends StatelessWidget {
  Review({super.key});
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate your Experience'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight(context)*0.02,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/avatar3.png',width: screenWidth(context)*0.22,),
                  SizedBox(width: screenWidth(context)*0.05,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ali Tailor's Shop",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
                      Text("Custom Wedding Suit ",style: const TextStyle(fontSize: 12,color: AppColors.greyColor,),),
                      Text("Order Date : 10/3/2024",style: const TextStyle(fontSize: 12,color: AppColors.greyColor,),),
                      Row(
                        children: [
                          Text("Order Status : ",style: const TextStyle(fontSize: 12,color: AppColors.greyColor,),),
                          Text("Delivered",style: const TextStyle(fontSize: 12,color: AppColors.greenColor,),),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: screenHeight(context)*0.03,
              ),
              Text("Leave a Review",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
              SizedBox(
                height: screenHeight(context)*0.01,
              ),
              Text("How would you  rate your experience with this product",style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500)),
              SizedBox(
                height: screenHeight(context)*0.01,
              ),
              RatingBar(
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                size: 23,
                onRatingChanged: (value) => debugPrint('$value'),
                initialRating: 1,
                maxRating: 5,
              ),
              SizedBox(
                height: screenHeight(context)*0.01,
              ),
              TextFormField(
                controller: controller,
                cursorColor: AppColors.darkBlueColor,
                maxLines: 4,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  hintText: "Write your review here...",
                  hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 1, color: AppColors.greyColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 1, color: AppColors.greyColor),
                  )
                ),
              ),
              SizedBox(
                height: screenHeight(context)*0.4,
              ),
              Row(
                children: [
                  Expanded(child: BorderCustomButton(onTap: (){}, text: "Skip",
                    textColor: Colors.black,
                    firstColor: AppColors.greyColor,secondColor: AppColors.greyColor,)),
                  SizedBox(
                    width: screenWidth(context)*0.05,
                  ),
                  Expanded(child: CustomButton(onTap: (){}, text: "Submit",))
                ],
              ),
              SizedBox(
                height: screenHeight(context)*0.02,
              ),
        
            ],
          ),
        ),
      ),
    );
  }
}
