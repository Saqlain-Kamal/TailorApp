import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/cubit/review_cubit/review_states.dart';
import 'package:tailor_app/app/model/review_model.dart';
import 'package:tailor_app/app/repo/review_repo.dart';

class ReviewCubit extends Cubit<ReviewStates> {
  ReviewCubit() : super(ReviewInitialState());
  final db = ReviewRepo();
  Future<void> addReview({required ReviewModel review}) async {
    try {
      emit(ReviewLoadingState());
      await db.addReview(review: review);
      emit(ReviewLoadedState());
    } catch (e) {
      rethrow;
    }
  }
}
