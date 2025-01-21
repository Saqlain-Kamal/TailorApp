abstract class MeasurmentStates {}

class InitialStates extends MeasurmentStates {}

class LoadingStates extends MeasurmentStates {}

class MeasurementUploadedState extends MeasurmentStates {}

class ErrorState extends MeasurmentStates {
  final String message;
  ErrorState({required this.message});
}
