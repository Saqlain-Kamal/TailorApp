import 'package:tailor_app/app/model/user_model.dart';

abstract class FavoriteStates {}

class FavoriteInitialState extends FavoriteStates {}

class FavoriteLoadingState extends FavoriteStates {}

class FavoriteAddedState extends FavoriteStates {}

class FavoriteRemovedState extends FavoriteStates {}

class FavoriteLoadedState extends FavoriteStates {
  final List<UserModel>? tailors;
  FavoriteLoadedState({this.tailors});
}

class FavoriteErrorState extends FavoriteStates {
  final String? message;
  FavoriteErrorState({this.message});
}
