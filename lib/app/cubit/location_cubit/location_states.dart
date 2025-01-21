abstract class LocationStates {}

class InitialStates extends LocationStates {}

class LoadingStates extends LocationStates {}

class LocationAccessedStates extends LocationStates {}

class ErrorState extends LocationStates {
  final String message;
  ErrorState({required this.message});
}
