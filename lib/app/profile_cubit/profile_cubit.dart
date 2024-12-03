import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/model/user_model.dart';
import 'package:tailor_app/app/auth/repo/auth_repo.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/profile_cubit/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(InitialStates());

  final authRepo = AuthRepo();
  UserModel? appUser;

  Future<void> updateTailorDetails(
      {required UserModel user, required BuildContext context}) async {
    try {
      emit(LoadingStates());
      await authRepo.updateTailorDetails(user: user);
      appUser = user;
      context.read<AuthCubit>().updateUser(user);
      emit(TailorInfoChangedState());
    } catch (e) {
      log('message');
      emit(
        ErrorState(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> changePassword(
      String currentPassword, String newPassword, BuildContext context) async {
    emit(LoadingStates());

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
        emit(PasswordChangedState());
      } on FirebaseAuthException catch (e) {
        emit(ErrorState(message: e.message!));
        print("Error: ${e.message}");
      }
    }
  }
}
