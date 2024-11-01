import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tailor_app/app/auth/model/user_model.dart';

class AuthRepo {
  Future<void> signUpUser(
      {required UserModel user, required UserCredential credential}) async {
    try {
      print('i am here');
      user.id = credential.user!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .set(user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  User? isCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future<UserModel?> getUserById({required String uid}) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    final data = snapshot.data();
    if (data != null) {
      return UserModel.fromJson(data);
    } else {
      return null; // Return null if data is null
    }
  }
}
