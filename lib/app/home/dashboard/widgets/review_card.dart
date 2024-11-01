import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tailor_app/utils/colors.dart';
import 'package:tailor_app/utils/container_decoration.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: reusableBoxDecoration,
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/avatar3.png'),
              ),
              title: const Text('Ahmad Ali'),
              subtitle: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: RatingBar(
                      size: 16,
                      maxRating: 5,
                      filledColor: AppColors.goldenColor,
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star,
                      onRatingChanged: (p0) {},
                      initialRating: 1,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/clock.svg',
                        color: AppColors.greyColor,
                        height: 18,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text('Apr 22, 2024')
                    ],
                  ),
                ],
              ),
            ),
            Text(
              'Great Service! My dress was ready on time, and the stiching was flawless.',
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}
