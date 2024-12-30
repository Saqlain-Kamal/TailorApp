import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String reviewMessage;
  final String name;

  final DateTime reviewTime;
  final int rating;
  final String id;
  final String toId;
  final String? userimage;

  ReviewModel({
    required this.rating,
    required this.name,
    required this.reviewMessage,
    required this.reviewTime,
    this.userimage,
    required this.toId,
    required this.id,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
        rating: json['rating'],
        name: json['name'],
        reviewMessage: json['reviewMessage'],
        reviewTime: (json['reviewTime'] as Timestamp).toDate(),
        id: json['id'],
        toId: json['toId'],
        userimage: json['userimage']);
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'name': name,
      'reviewMessage': reviewMessage,
      'reviewTime': reviewTime,
      'id': id,
      'toId': toId,
      'userimage': userimage,
    };
  }
}
