import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final currentUser = authRepo.isCurrentUser();
      log("${currentUser.toString()}tttttttttttttt");

      if (currentUser != null) {
        appUser = await authRepo.getUserById(uid: currentUser.uid);
        log("${appUser!.name.toString()}hhhhhhhhhhhhh");
        if (appUser != null) {
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
}
