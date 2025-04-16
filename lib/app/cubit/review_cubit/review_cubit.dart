import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/cubit/review_cubit/review_states.dart';
import 'package:tailor_app/app/model/review_model.dart';
import 'package:tailor_app/app/repo/review_repo.dart';

class ReviewController extends ChangeNotifier {
  bool isloading = false;
  final db = ReviewRepo();
  Future<void> addReview({required ReviewModel review}) async {
    try {
      // emit(ReviewLoadingState());
      isloading = true;
      notifyListeners();
      await db.addReview(review: review);
      // emit(ReviewLoadedState());
      isloading = false;
      notifyListeners();
    } catch (e) {
      isloading = false;
      notifyListeners();
      rethrow;
    }
  }
}
