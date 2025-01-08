abstract class SendRequestStates {}

class InitialStates extends SendRequestStates {}

class LoadingStates extends SendRequestStates {}

class RequestSendedStates extends SendRequestStates {}

class RequestAcceptedStates extends SendRequestStates {}

class OrderApprovedState extends SendRequestStates {}

class OrderNotApprovedState extends SendRequestStates {}

class OrderNotFoundState extends SendRequestStates {}

class ErrorState extends SendRequestStates {
  final String message;
  ErrorState({required this.message});
}
