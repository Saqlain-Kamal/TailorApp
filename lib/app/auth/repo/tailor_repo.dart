import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tailor_app/app/auth/model/user_model.dart';

class TailorRepo {
  Future<List<UserModel>> getTailors() async {
    try {
      final usersRef = FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'Tailor');
      final querySnapshot = await usersRef.get();

      final users = querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
      log(users.length.toString());

      return users;
    } on FirebaseException catch (e) {
      // Handle Firebase errors appropriately (e.g., logging, user notifications)
      rethrow;
    }
  }
}
