import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/cubit/favorite_cubit/favorite_cubit.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/utils/colors.dart';

import '../../../../utils/mediaquery.dart';

class TailorListingCard extends StatefulWidget {
  const TailorListingCard({
    super.key,
    required this.name,
    required this.cityName,
    this.showFavorite = false,
    required this.image,
    this.user,
  });
  final String name;
  final String image;
  final String cityName;
  final bool showFavorite;
  final UserModel? user;

  @override
  State<TailorListingCard> createState() => _TailorListingCardState();
}

class _TailorListingCardState extends State<TailorListingCard> {
  bool toggleIcon = false;
  bool isFavorite = false;

  @override
  void initState() {
    if (widget.user != null) {
      context
          .read<FavoriteCubit>()
          .isFavorite(widget.user!, context)
          .then((value) {
        setState(() {
          isFavorite = value;
        });
      });
    }
    super.initState();
  }

  void _toggleFavorite({required UserModel user}) {
    setState(() {
      isFavorite = !isFavorite; // Update UI immediately
    });

    if (isFavorite) {
      context
          .read<FavoriteCubit>()
          .addToFav(user: user, uid: context.read<AuthCubit>().appUser!.id!);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
        duration: Duration(seconds: 2),
        backgroundColor: AppColors.darkBlueColor,
        content: Text("Added To Favorites"),
      ));
    } else {
      context.read<FavoriteCubit>().removeItemFromCart(
          user: user, uid: context.read<AuthCubit>().appUser!.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              widget.user?.name ?? '..',
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
                  widget.user?.location ?? '',
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
          widget.user != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Column(
                      children: [
                        Text("PKR 2000 - 8000", style: TextStyle(fontSize: 12)),
                        Text("Custom Stitching",
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    if (widget.showFavorite)
                      GestureDetector(
                        onTap: () => _toggleFavorite(user: widget.user!),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 30,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
