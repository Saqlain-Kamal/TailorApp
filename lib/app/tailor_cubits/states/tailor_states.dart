import 'package:tailor_app/app/auth/model/user_model.dart';

abstract class TailorStates {}

class TailorInitialState extends TailorStates {}

class TailorLoadingState extends TailorStates {}

class TailorLoadedState extends TailorStates {
  final List<UserModel>? tailors;
  TailorLoadedState({this.tailors});
}

class TailorErrorState extends TailorStates {
  final String? message;
  TailorErrorState({this.message});
}
