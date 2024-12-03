import 'package:tailor_app/app/auth/model/user_model.dart';

abstract class AuthStates {}

class InitialState extends AuthStates {}

class LoadingState extends AuthStates {}

class SplashLoadingState extends AuthStates {}

class PasswordChangedState extends AuthStates {}

class AccountDeletedState extends AuthStates {}

class AuthenticatedState extends AuthStates {
  final UserModel user;
  final String? message;
  AuthenticatedState({
    required this.user,
    this.message,
  });
}

class LoadedState extends AuthStates {
  final UserModel user;
  LoadedState({required this.user});
}

class UnAuthenticatedState extends AuthStates {}

class CreateUserUnAuthenticatedState extends AuthStates {}

class ErrorState extends AuthStates {
  final String message;
  ErrorState({required this.message});
}
