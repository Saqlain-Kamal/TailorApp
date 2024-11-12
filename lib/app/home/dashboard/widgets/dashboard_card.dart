import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tailor_app/app/extension/padding.dart';
import 'package:tailor_app/utils/colors.dart';
import 'package:tailor_app/utils/mediaquery.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    this.svg,
    this.asset,
    required this.text,
    this.onTap,
    super.key,
  });
  final String? asset;
  final String? svg;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        width: screenWidth(context) * 0.45,
        height: screenHeight(context) * 0.12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: AppColors.borderGreyColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                svg != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: SvgPicture.asset(svg!),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Image.asset(
                          asset!,
                          height: 26,
                        ),
                      ),
                Expanded(child: Text(text).paddingOnly(left: 8)),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 42),
                  child: Text('14'),
                ),
                Icon(Icons.arrow_forward_rounded)
              ],
            )
          ],
        ),
      ),
    );
  }
}
