import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/home/dashboard/widgets/review_card.dart';
import 'package:tailor_app/app/model/review_model.dart';
import 'package:tailor_app/app/utils/constants.dart';

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
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('reviews')
                        .doc(context.read<AuthCubit>().appUser!.id)
                        .collection('myReviews')
                        .orderBy('rating', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Text('data');
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('NO REVIEWS'));
                      }
                      final data = snapshot.data!.docs
                          .map((e) => ReviewModel.fromJson(e.data()))
                          .toList();
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final singleReview = data[index];
                            return ReviewCard(
                              review: singleReview,
                            );
                          });
                    }))
          ],
        ),
      ),
    );
  }
}
