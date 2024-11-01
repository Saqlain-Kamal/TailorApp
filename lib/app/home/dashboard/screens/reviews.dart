import 'package:flutter/material.dart';
import 'package:tailor_app/app/home/dashboard/widgets/review_card.dart';
import 'package:tailor_app/utils/constants.dart';

class Reviews extends StatelessWidget {
  const Reviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.customerReviews,
              style: TextStyle(fontSize: 22),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const ReviewCard();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
