import 'package:tailor_app/app/auth/model/user_model.dart';

abstract class AuthStates {}

class InitialState extends AuthStates {}

class LoadingState extends AuthStates {}

class SplashLoadingState extends AuthStates {}

class AuthenticatedState extends AuthStates {
  final UserModel user;
  AuthenticatedState({required this.user});
}

class UnAuthenticatedState extends AuthStates {}

class ErrorState extends AuthStates {
  final String message;
  ErrorState({required this.message});
}
