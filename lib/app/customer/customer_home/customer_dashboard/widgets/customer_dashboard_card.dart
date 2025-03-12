import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tailor_app/app/extension/padding.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/mediaquery.dart';

class CustomerDashboardCard extends StatelessWidget {
  const CustomerDashboardCard({
    this.svg,
    this.asset,
    required this.text,
    required this.countText,
    this.onTap,
    super.key,
  });
  final String? asset;
  final String? svg;
  final String text;
  final String countText;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        width: screenWidth(context) * 0.28,
        height: screenHeight(context) * 0.14,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 2,
                  color: Colors.grey.shade300,
                  offset: const Offset(1, 2)),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: AppColors.borderGreyColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Text(
              text,
              style: const TextStyle(fontSize: 13),
            ).paddingOnly(left: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                    countText.padLeft(2, '0'),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight(context) * 0.01,
            )
          ],
        ),
      ),
    );
  }
}
