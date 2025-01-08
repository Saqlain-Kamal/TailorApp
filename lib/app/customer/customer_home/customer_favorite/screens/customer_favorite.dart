import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/cubit/favorite_cubit/favorite_cubit.dart';
import 'package:tailor_app/app/cubit/favorite_cubit/favorite_states.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/screens/tailor_detail.dart';

import '../../../../utils/mediaquery.dart';
import '../../customer_dashboard/widgets/tailor_listing_card.dart';

class CustomerFavorite extends StatefulWidget {
  const CustomerFavorite({
    super.key,
  });

  @override
  State<CustomerFavorite> createState() => _CustomerFavoriteState();
}

class _CustomerFavoriteState extends State<CustomerFavorite> {
  @override
  void initState() {
    getFavoritesTailors();
    super.initState();
  }

  void getFavoritesTailors() async {
    await context
        .read<FavoriteCubit>()
        .fetchFavorites(uid: context.read<AuthCubit>().appUser!.id!);
    await context
        .read<FavoriteCubit>()
        .fetchFavoritesCount(uid: context.read<AuthCubit>().appUser!.id!);
  }

  @override
  Widget build(BuildContext context) {
    final fav = context.read<FavoriteCubit>().favorites;
    log(
      fav.map((e) => e..toString()).toString(),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Tailors'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight(context) * 0.03,
            ),
            Flexible(
              child: BlocConsumer<FavoriteCubit, FavoriteStates>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is FavoriteLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is FavoriteLoadedState) {
                    final tailors = context.read<FavoriteCubit>().favorites;
                    return tailors.isNotEmpty
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8.0,
                              crossAxisSpacing: 8.0,
                              childAspectRatio: 1.2,
                            ),
                            itemCount: tailors.length,
                            itemBuilder: (context, index) {
                              final tailor = tailors[index];
                              log(tailor.name.toString());
                              return InkWell(
                                onTap: () {
                                  log('message');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TailorDetail(
                                        tailor: tailor,
                                      ),
                                    ),
                                  );
                                },
                                child: TailorListingCard(
                                  cityName: tailor.location ?? '',
                                  name: tailor.name!,
                                  showFavorite: false,
                                  image: 'assets/images/avatar3.png',
                                  user: tailor,
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                                'No Tailors Have Been Added in the Favorites !'),
                          );
                  }
                  return const SizedBox();
                },
              ),
            ),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
