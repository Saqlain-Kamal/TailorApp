import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/cubit/favorite_cubit/favorite_states.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/repo/auth_repo.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit() : super(FavoriteInitialState());
  final authRepo = AuthRepo();
  List<UserModel> favorites = [];
  int favLength = 0;

  Future<void> fetchFavorites({required String uid}) async {
    try {
      emit(FavoriteLoadingState());
      favorites = await authRepo.getFavorites(uid);
      log(favorites.length.toString()); // Fetch from Firebase
      emit(FavoriteLoadedState(tailors: favorites));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchFavoritesCount({required String uid}) async {
    try {
      emit(FavoriteLoadingState());
      favLength = await authRepo.fetchFavoritesCount(uid);
      log(favLength.toString()); // Fetch from Firebase
      emit(FavoriteLoadedState(tailors: favorites));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addToFav({required UserModel user, required String uid}) async {
    try {
      await authRepo.addToFav(user: user, uid: uid);
      emit(FavoriteAddedState());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeItemFromCart(
      {required UserModel user, required String uid}) async {
    try {
      await authRepo.removeItemFromFav(user: user, uid: uid);
      // emit(state.where((favorite) => favorite.id != user.id).toList());
      emit(FavoriteRemovedState());
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isFavorite(UserModel user, BuildContext context) async {
    try {
      final uid = context.read<AuthCubit>().appUser!.id!;
      return await authRepo.isFavorite(userId: user.id!, uid: uid);
    } catch (e) {
      rethrow;
    }
  }
}
