abstract class ProfileStates {}

class InitialStates extends ProfileStates {}

class LoadingStates extends ProfileStates {}

class TailorInfoChangedState extends ProfileStates {}

class PasswordChangedState extends ProfileStates {}

class ErrorState extends ProfileStates {
  final String message;
  ErrorState({required this.message});
}
