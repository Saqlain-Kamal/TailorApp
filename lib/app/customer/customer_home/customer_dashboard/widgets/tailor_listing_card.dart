import 'package:flutter/material.dart';
import 'package:tailor_app/utils/colors.dart';

import '../../../../../utils/mediaquery.dart';

class TailorListingCard extends StatefulWidget {
  const TailorListingCard({
    super.key,
    required this.name,
    required this.cityName,
    this.showFavorite = false,
    required this.onTap,
    required this.image,
  });
  final String name;
  final String image;
  final String cityName;
  final bool showFavorite;
  final void Function()? onTap;

  @override
  State<TailorListingCard> createState() => _TailorListingCardState();
}

class _TailorListingCardState extends State<TailorListingCard> {
  bool toggleIcon = false;
  void _toggleFavorite() {
    setState(() {
      toggleIcon = !toggleIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
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
              leading: CircleAvatar(
                backgroundImage: AssetImage(widget.image),
                radius: 20,
              ),
              title: Text(
                widget.name,
                style: const TextStyle(fontSize: 12),
              ),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 15,
                  ),
                  Text(
                    widget.cityName,
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Row(
              children: [
                Icon(
                  Icons.star,
                  size: 15,
                  color: AppColors.ratingColor,
                ),
                Icon(
                  Icons.star,
                  size: 15,
                  color: AppColors.ratingColor,
                ),
                Icon(
                  Icons.star,
                  size: 15,
                  color: AppColors.ratingColor,
                ),
                Icon(
                  Icons.star,
                  size: 15,
                  color: AppColors.ratingColor,
                ),
                Icon(
                  Icons.star,
                  size: 15,
                  color: AppColors.greyColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Column(
                  children: [
                    Text("PKR 2000 - 8000", style: TextStyle(fontSize: 12)),
                    Text("Custom Stitching", style: TextStyle(fontSize: 12)),
                  ],
                ),
                if (widget.showFavorite)
                  InkWell(
                    onTap: _toggleFavorite,
                    child: Icon(
                      toggleIcon ? Icons.favorite : Icons.favorite_border,
                      color: toggleIcon ? Colors.red : Colors.grey,
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
