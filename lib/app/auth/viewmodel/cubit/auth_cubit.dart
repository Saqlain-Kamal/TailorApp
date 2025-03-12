import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tailor_app/app/auth/viewmodel/states/auth_states.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/repo/auth_repo.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(InitialState());
  UserModel? appUser;
  final authRepo = AuthRepo();
  LatLng? currentPosition;
  String? currentDistrict;

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
          emit(AuthenticatedState(
              user: appUser!, message: 'Logged In Succesfully'));
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
      emit(LocationLoadingState());
      await Future.delayed(const Duration(seconds: 2));
      log('Loading State');
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: user.email!, password: password);
      appUser = user;
      await authRepo.signUpUser(user: user, credential: userCredential);
      // emit(LocationAccessedStates());
      emit(
        AuthenticatedState(
            user: appUser!, message: 'Account Created Succesfully'),
      );
      log(appUser.toString());
      log('Authenticated State');

      return userCredential;
    } catch (e) {
      log('Unknown exception: $e');
      emit(ErrorState(message: 'An unknown error occurred.'));
      rethrow;
    }
  }

  Future<void> signupwithGoogle({
    required UserModel user,
  }) async {
    try {
      emit(LoadingState());
      await authRepo.googleSignUp(user);
      final currentUser = authRepo.isCurrentUser();
      log("${currentUser.toString()}tttttttttttttt");

      if (currentUser != null) {
        appUser = await authRepo.getUserById(uid: currentUser.uid);
        if (appUser != null) {
          log("${appUser!.name.toString()}hhhhhhhhhhhhh");
          emit(AuthenticatedState(
              user: appUser!, message: 'Logged In Successfully'));
          // emit(AuthenticatedState(user: appUser!));
        } else {
          log("User data is null");
          emit(UnAuthenticatedState());
        }
      } else {
        log("Current user is null");
      }

      // appUser = user;
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
        log(isCurrentUser.email!);
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
      // emit(CreateUserUnAuthenticatedState());
    } catch (e) {
      emit(ErrorState(message: e.toString()));
      log('Error signing out: $e');
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

  void updateUser(UserModel user) {
    appUser = user;
    emit(AuthenticatedState(user: user));
    // Emit a state if needed
  }

  // Future<void> updateUserLocation(UserModel user) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user.id) // Ensure 'id' is the document ID in Firestore
  //         .update({
  //       'location': GeoPoint(user.location!.latitude, user.location!.longitude),
  //       'place': user.place,
  //     });
  //     appUser = user;
  //     emit(AuthenticatedState(user: user));
  //     log('User updated successfully in Firestore');
  //   } catch (e) {
  //     log('Error updating user: $e');
  //   }
  // }

  Future<void> getPermission() async {
    emit(LocationLoadingState());
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      double lat = position.latitude;
      double long = position.longitude;
      log(lat.toString());
      log(long.toString());
      currentPosition = LatLng(lat, long);
      log(currentPosition.toString());
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      log(placemark.toString());
      Placemark place = placemark[0];
      currentDistrict = place.administrativeArea;

      emit(LocationAccessedStates());
    }
  }

  void goToCreateAccount() => emit(AccountCreateScreenState());
  void goToContinueProfile(UserModel user, String password) =>
      emit(ContinueProfileScreenState(user: user, password: password));
  void goToLocationScreen(UserModel user, String password) =>
      emit(LocationAccessScreenState(user: user, password: password));
}
