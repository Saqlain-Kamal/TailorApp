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
          .read<FavoriteController>()
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
      context.read<FavoriteController>().addToFav(
          user: user, uid: context.read<AuthController>().appUser!.id!);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
        duration: Duration(seconds: 2),
        backgroundColor: AppColors.darkBlueColor,
        content: Text("Added To Favorites"),
      ));
    } else {
      context.read<FavoriteController>().removeItemFromCart(
          user: user, uid: context.read<AuthController>().appUser!.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                spreadRadius: 2,
                color: Colors.grey.shade300,
                offset: const Offset(1, 1)),
          ],
          color: Colors.white,
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
              radius: 30,
            ),
            title: Text(
              widget.user?.name ?? '..',
              style: const TextStyle(fontSize: 15),
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Icon(
                //   Icons.location_on_outlined,
                //   size: 15,
                // ),
                SizedBox(
                  width: screenWidth(context) * 0.23,
                  child: Text(
                    widget.user?.place ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
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
                  children: [
                    const SizedBox(
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("PKR 2000 - 8000",
                              style: TextStyle(fontSize: 15)),
                          Text("Custom Stitching",
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
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
