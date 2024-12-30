import 'package:tailor_app/app/model/review_model.dart';

abstract class ReviewStates {}

class ReviewInitialState extends ReviewStates {}

class ReviewLoadingState extends ReviewStates {}

class ReviewAddedState extends ReviewStates {}

class ReviewRemovedState extends ReviewStates {}

class ReviewLoadedState extends ReviewStates {
  final List<ReviewModel>? reviews;
  ReviewLoadedState({this.reviews});
}

class ReviewErrorState extends ReviewStates {
  final String? message;
  ReviewErrorState({this.message});
}
