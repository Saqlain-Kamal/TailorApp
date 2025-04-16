import 'dart:developer';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';

import 'package:tailor_app/app/cubit/review_cubit/review_cubit.dart';
import 'package:tailor_app/app/cubit/review_cubit/review_states.dart';
import 'package:tailor_app/app/extension/snackbar.dart';
import 'package:tailor_app/app/model/review_model.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/utils/border_custom_button.dart';
import 'package:tailor_app/app/utils/custom_button.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

import '../../../../utils/colors.dart';

class AddReview extends StatelessWidget {
  AddReview({super.key, required this.user});
  final TextEditingController reviewController = TextEditingController();
  final UserModel user;
  double rating = 0.0;
  @override
  Widget build(BuildContext context) {
    log(user.toJson().toString());
    // context.read<ReviewCubit>().emit(ReviewInitialState());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate your Experience'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight(context) * 0.02,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/avatar3.png',
                    width: screenWidth(context) * 0.22,
                  ),
                  SizedBox(
                    width: screenWidth(context) * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name!,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                      const Text(
                        "Custom Wedding Suit ",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.greyColor,
                        ),
                      ),
                      const Text(
                        "Order Date : 10/3/2024",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.greyColor,
                        ),
                      ),
                      const Row(
                        children: [
                          Text(
                            "Order Status : ",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.greyColor,
                            ),
                          ),
                          Text(
                            "Delivered",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.greenColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: screenHeight(context) * 0.03,
              ),
              const Text("Leave a Review",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              SizedBox(
                height: screenHeight(context) * 0.01,
              ),
              const Text(
                  "How would you  rate your experience with this product",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              SizedBox(
                height: screenHeight(context) * 0.01,
              ),
              RatingBar(
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                size: 23,
                onRatingChanged: (value) {
                  rating = value;
                },
                initialRating: 1,
                maxRating: 5,
              ),
              SizedBox(
                height: screenHeight(context) * 0.01,
              ),
              TextFormField(
                controller: reviewController,
                cursorColor: AppColors.darkBlueColor,
                maxLines: 4,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    hintText: "Write your review here...",
                    hintStyle:
                        TextStyle(color: Colors.grey.shade500, fontSize: 13),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(width: 1, color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          width: 1, color: AppColors.greyColor),
                    )),
              ),
              SizedBox(
                height: screenHeight(context) * 0.4,
              ),
              Row(
                children: [
                  Expanded(
                      child: BorderCustomButton(
                    onTap: () {},
                    text: "Skip",
                    textColor: Colors.black,
                    firstColor: AppColors.darkBlueColor,
                    secondColor: AppColors.blueColor,
                  )),
                  SizedBox(
                    width: screenWidth(context) * 0.05,
                  ),
                  Expanded(
                    child: CustomButton(
                      onTap: () async {
                        try {
                          final review = ReviewModel(
                              rating: rating.toInt(),
                              reviewMessage: reviewController.text,
                              reviewTime: DateTime.now(),
                              name:
                                  context.read<AuthController>().appUser!.name!,
                              id: context.read<AuthController>().appUser!.id!,
                              toId: user.id!);
                          await context
                              .read<ReviewController>()
                              .addReview(review: review);
                          context.mySnackBar(
                              text: 'Review Added Successflly',
                              color: AppColors.darkBlueColor);
                        } catch (e) {
                          context.mySnackBar(
                              text: e.toString(), color: Colors.red);
                          rethrow;
                        }
                      },
                      text: "Submit",
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight(context) * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
