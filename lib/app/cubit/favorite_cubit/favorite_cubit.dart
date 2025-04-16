import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/cubit/favorite_cubit/favorite_states.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/repo/auth_repo.dart';

class FavoriteController extends ChangeNotifier {
  final authRepo = AuthRepo();
  List<UserModel> favorites = [];
  int favLength = 0;
  bool isloading = false;

  Future<void> fetchFavorites({required String uid}) async {
    try {
      // emit(FavoriteLoadingState());
      isloading = true;
      notifyListeners();
      favorites = await authRepo.getFavorites(uid);
      log(favorites.length.toString()); // Fetch from Firebase
      // emit(FavoriteLoadedState(tailors: favorites));
      isloading = false;
      notifyListeners();
    } catch (e) {
      isloading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> fetchFavoritesCount({required String uid}) async {
    try {
      // emit(FavoriteLoadingState());
      isloading = true;
      notifyListeners();
      favLength = await authRepo.fetchFavoritesCount(uid);
      log(favLength.toString()); // Fetch from Firebase
      // emit(FavoriteLoadedState(tailors: favorites));
      isloading = false;
      notifyListeners();
    } catch (e) {
      isloading = true;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> addToFav({required UserModel user, required String uid}) async {
    try {
      await authRepo.addToFav(user: user, uid: uid);
      // emit(FavoriteAddedState());

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeItemFromCart(
      {required UserModel user, required String uid}) async {
    try {
      await authRepo.removeItemFromFav(user: user, uid: uid);
      // emit(state.where((favorite) => favorite.id != user.id).toList());
      // emit(FavoriteRemovedState());
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isFavorite(UserModel user, BuildContext context) async {
    try {
      final uid = context.read<AuthController>().appUser!.id!;
      return await authRepo.isFavorite(userId: user.id!, uid: uid);
    } catch (e) {
      rethrow;
    }
  }
}
