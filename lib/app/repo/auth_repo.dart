import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tailor_app/app/model/user_model.dart';

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

  Future<void> googleSignUp(UserModel user) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(user.id).set(
            user.toJson(),
          );
    } catch (e) {
      log(e.toString());
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

  Future<void> updateTailorDetails({required UserModel user}) async {
    try {
      // User? firebaseUser = FirebaseAuth.instance.currentUser;
      // if (firebaseUser != null && user.email != firebaseUser.email) {

      //   await firebaseUser.verifyBeforeUpdateEmail(user.email!);
      // }

      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        throw Exception('No Internet Connection');
      }

      log(user.id.toString());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .update(user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUserAndFirestoreData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String uid = user.uid;

        // Re-authenticate the user with Google
        final GoogleSignIn googleSignIn = GoogleSignIn();
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;

          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          // Re-authenticate
          await user.reauthenticateWithCredential(credential);

          // Delete Firestore data
          await FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .delete();

          // Delete the user from Firebase Auth
          await user.delete();

          log("User and Firestore data deleted successfully.");
        } else {
          log("Google sign-in failed.");
        }
      } else {
        log("No user is signed in.");
      }
    } catch (e) {
      log("Error deleting user and Firestore data: $e");
    }
    //   try {
    //     User? user = FirebaseAuth.instance.currentUser;

    //     if (user != null) {
    //       String uid = user.uid;

    //       // Delete Firestore data
    //       await FirebaseFirestore.instance.collection('users').doc(uid).delete();

    //       // Re-authenticate if necessary
    //       // Example re-authentication (if required)
    //       // AuthCredential credential = EmailAuthProvider.credential(
    //       //   email: user.email!,
    //       //   password: 'userPassword',
    //       // );
    //       // await user.reauthenticateWithCredential(credential);

    //       // Delete the user from Firebase Auth
    //       await user.delete();

    //       print("User and Firestore data deleted successfully.");
    //     } else {
    //       print("No user is signed in.");
    //     }
    //   } catch (e) {
    //     print("Error deleting user and Firestore data: $e");
    //   }
  }

  Future<void> addToFav({required UserModel user, required String uid}) async {
    try {
      final newDocRef = FirebaseFirestore.instance
          .collection('favorites')
          .doc(uid)
          .collection('tailors')
          .doc(user.id);
      await newDocRef.set(user.toJson());
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  Future<bool> isFavorite({required String userId, required String uid}) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .doc(uid)
          .collection('tailors')
          .doc(userId)
          .get();

      return docSnapshot.exists; // Returns true if the document exists
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  Future<void> removeItemFromFav(
      {required UserModel user, required String uid}) async {
    try {
      await FirebaseFirestore.instance
          .collection('favorites')
          .doc(uid)
          .collection('tailors')
          .doc(user.id)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getFavorites(String uid) async {
    // Replace with your Firebase fetching logic
    final snapshot = await FirebaseFirestore.instance
        .collection('favorites')
        .doc(uid)
        .collection('tailors')
        .get();

    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  Future<int> fetchFavoritesCount(String uid) async {
    // Replace with your Firebase fetching logic
    final snapshot = await FirebaseFirestore.instance
        .collection('favorites')
        .doc(uid)
        .collection('tailors')
        .get();
    final int itemCount = snapshot.size;
    print('Number of items: $itemCount');
    return itemCount;
  }
}
