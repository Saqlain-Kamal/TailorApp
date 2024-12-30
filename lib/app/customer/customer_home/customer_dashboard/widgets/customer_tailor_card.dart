import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tailor_app/app/extension/padding.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

class CustomerTailorCard extends StatelessWidget {
  const CustomerTailorCard({
    this.svg,
    this.asset,
    required this.text,
    required this.rating,
    required this.priceText,
    this.onTap,
    super.key,
  });
  final String? asset;
  final String? svg;
  final String text;
  final String rating;
  final String priceText;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        width: screenWidth(context) * 0.34,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: AppColors.borderGreyColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            svg != null
                ? Padding(
              padding: const EdgeInsets.only(left: 6),
              child: SvgPicture.asset(svg!),
            )
                : Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Image.asset(
                asset!,
                height: 26,
              ),
            ),
            Text(text,style: const TextStyle(fontSize: 12)).paddingOnly(left: 6),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star,size: 15,color: AppColors.ratingColor,),
                Text(rating),
              ],
            ),
            const SizedBox(height: 5,),
            Text("Starting from PKR $priceText",style: const TextStyle(fontSize: 10)).paddingOnly(left: 6),
          ],
        ),
      ),
    );
  }
}
