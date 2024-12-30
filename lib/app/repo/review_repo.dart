import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tailor_app/app/model/review_model.dart';

class ReviewRepo {
  Future<void> addReview({required ReviewModel review}) async {
    try {
      await FirebaseFirestore.instance
          .collection('reviews')
          .doc(review.toId)
          .collection('myReviews')
          .doc()
          .set(review.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
