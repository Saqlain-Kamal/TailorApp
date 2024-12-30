import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/screens/tailor_detail.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/widgets/tailor_listing_card.dart';
import 'package:tailor_app/app/cubit/tailor_cubits/cubits/tailor_cubit.dart';
import 'package:tailor_app/app/cubit/tailor_cubits/states/tailor_states.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/mediaquery.dart';
import '../../../../auth/widgets/custom_text_field.dart';

class TailorListing extends StatefulWidget {
  const TailorListing({super.key});

  @override
  State<TailorListing> createState() => _TailorListingState();
}

class _TailorListingState extends State<TailorListing> {
  @override
  void initState() {
    getTailors();
    super.initState();
  }

  void getTailors() async {
    await context.read<TailorCubit>().getTailors();
    // context
    //     .read<FavoriteCubit>()
    //     .fetchFavorites(uid: context.read<AuthCubit>().appUser!.id!);
  }

  @override
  Widget build(BuildContext context) {
    final tailors = context.read<TailorCubit>().tailorList;
    log(
      tailors.map((e) => e..toString()).toString(),
    );
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                    child: CustomeTextField(
                  hint: "Search for Tailors",
                  prefixIcon: 'assets/images/Search.png',
                )),
                SizedBox(
                  width: screenWidth(context) * 0.01,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  height: screenHeight(context) * 0.06,
                  width: screenWidth(context) * 0.13,
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 1, color: AppColors.borderGreyColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.notifications),
                )
              ],
            ),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
            const Text(
              "Tailors Listings",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
            Flexible(
              child: BlocConsumer<TailorCubit, TailorStates>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is TailorLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is TailorLoadedState) {
                    final tailors = context.read<TailorCubit>().tailorList;
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
                                  cityName: tailor.location!,
                                  name: tailor.name!,
                                  showFavorite: true,
                                  image: 'assets/images/avatar3.png',
                                  user: tailor,
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text('Empty'),
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
