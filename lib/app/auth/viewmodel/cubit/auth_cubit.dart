import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:tailor_app/app/auth/model/user_model.dart';
import 'package:tailor_app/app/auth/repo/auth_repo.dart';
import 'package:tailor_app/app/auth/viewmodel/states/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(InitialState());
  UserModel? appUser;
  final authRepo = AuthRepo();

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> sighInWithEmailAndPassword(
      String email, String password) async {
    try {
      emit(LoadingState());
      await Future.delayed(const Duration(seconds: 2));
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final currentUser = authRepo.isCurrentUser();
      log("${currentUser.toString()}tttttttttttttt");

      if (currentUser != null) {
        appUser = await authRepo.getUserById(uid: currentUser.uid);
        if (appUser != null) {
          log("${appUser!.name.toString()}hhhhhhhhhhhhh");
          emit(AuthenticatedState(user: appUser!));
        } else {
          log("User data is null");
          emit(UnAuthenticatedState());
        }
      } else {
        log("Current user is null");
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      emit(ErrorState(message: 'Wrong Credentials'));
      throw Exception('error is${e.message}');
    }
  }

  Future<UserCredential> sighUpWithEmailAndPassword(
      UserModel user, String password) async {
    try {
      emit(LoadingState());
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: user.email!, password: password);
      appUser = user;
      emit(AuthenticatedState(user: appUser!));
      await authRepo.signUpUser(user: user, credential: userCredential);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      emit(ErrorState(message: e.message!));
      throw Exception('error is${e.message}');
    }
  }

  Future<void> signupwithGoogle({
    required UserModel user,
  }) async {
    try {
      emit(LoadingState());
      await authRepo.googleSignUp(user);
      appUser = user;
      emit(AuthenticatedState(user: appUser!));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<User?> checkCurrentUser(BuildContext context) async {
    try {
      emit(SplashLoadingState());
      await Future.delayed(const Duration(seconds: 3));
      emit(LoadingState());
      await Future.delayed(const Duration(seconds: 3));
      final isCurrentUser = authRepo.isCurrentUser();
      if (isCurrentUser != null) {
        appUser = await authRepo.getUserById(uid: isCurrentUser.uid);
        emit(AuthenticatedState(user: appUser!));
        log(appUser!.toJson().toString());
        //notifyListeners();
        return isCurrentUser;
      } else {
        emit(UnAuthenticatedState());
      }
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
      emit(UnAuthenticatedState());
    } catch (e) {
      emit(ErrorState(message: e.toString()));
      log('Error signing out: $e');
    }
  }

  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    emit(LoadingState());

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

  Future<void> updateTailorDetails({required UserModel user}) async {
    try {
      emit(LoadingState());
      await authRepo.updateTailorDetails(user: user);
      emit(TailorInfoChangedState());
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> deleteUserAndFirestoreData() async {
    try {
      emit(LoadingState());
      await authRepo.deleteUserAndFirestoreData();

      emit(AccountDeletedState());
      await signOut();
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}
