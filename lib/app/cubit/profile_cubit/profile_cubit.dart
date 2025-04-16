import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/cubit/profile_cubit/profile_states.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/repo/auth_repo.dart';

class ProfileController extends ChangeNotifier {
  final authRepo = AuthRepo();
  UserModel? appUser;
  bool isloading = false;

  Future<void> updateTailorDetails(
      {required UserModel user, required BuildContext context}) async {
    try {
      // emit(LoadingStates());
      isloading = true;
      notifyListeners();
      await authRepo.updateTailorDetails(user: user);
      appUser = user;

      context.read<AuthController>().updateUser(user);
      notifyListeners();
      // emit(TailorInfoChangedState());
      isloading = false;
      notifyListeners();
    } catch (e) {
      isloading = false;
      notifyListeners();
      log('message');
      rethrow;
      // emit(
      //   // ErrorState(
      //   //   message: e.toString(),
      //   // ),
      // );
    }
  }

  Future<void> changePassword(
      String currentPassword, String newPassword, BuildContext context) async {
    // emit(LoadingStates());
    isloading = true;
    notifyListeners();

    final currentUser = authRepo.isCurrentUser();

    if (currentUser != null) {
      try {
        // Re-authenticate the user with the current password
        AuthCredential credential = EmailAuthProvider.credential(
          email: currentUser.email!,
          password: currentPassword,
        );

        await currentUser.reauthenticateWithCredential(credential);

        // Update password after successful re-authentication
        await currentUser.updatePassword(newPassword);
        appUser = await authRepo.getUserById(uid: currentUser.uid);
        // await _auth.signOut(); // Optional: Sign out after password change
        log("Password changed successfully!");
        // emit(PasswordChangedState());
        isloading = false;
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        isloading = false;
        notifyListeners();
        // emit(ErrorState(message: e.message!));
        print("Error: ${e.message}");
        rethrow;
      }
    }
  }
}
