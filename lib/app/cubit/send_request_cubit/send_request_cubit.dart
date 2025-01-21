import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/cubit/send_request_cubit/send_request_states.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/repo/send_request_order_repo.dart';

class SendRequestCubit extends Cubit<SendRequestStates> {
  SendRequestCubit() : super(InitialStates());

  final db = SendRequestOrderRepo();
  String orderId = '';
  bool isOrderAlreadySend = false;
  bool isApproved = false;
  int newOrderLength = 0;
  int pendingOrderLength = 0;
  int progressOrderLength = 0;

  String appBarTitle = 'New Orders';
  Future<void> sendOrderRequest({
    required String senderUid,
    required String recieverUid,
    required UserModel senderUser,
    required UserModel recieverUser,
  }) async {
    try {
      log('sending');
      emit(LoadingStates());
      generateOrderID();
      db.sendRequest(
        senderUid: senderUid,
        recieverUid: recieverUid,
        senderUser: senderUser,
        recieverUser: recieverUser,
        orderId: orderId,
      );
      isOrderAlreadySend = true;
      emit(RequestSendedStates());
    } catch (e) {
      emit(
        ErrorState(
          message: e.toString(),
        ),
      );
      rethrow;
    }
  }

  Future<void> acceptOrder({
    required String myUid,
    required String otherUid,
  }) async {
    try {
      log('sending');
      emit(LoadingStates());

      final isOrderAccepted =
          await db.acceptOrder(myUid: myUid, otherUserUid: otherUid);

      if (isOrderAccepted) {
        emit(RequestAcceptedStates());
      } else {
        emit(OrderNotFoundState());
      }
    } catch (e) {
      emit(
        ErrorState(
          message: e.toString(),
        ),
      );
      rethrow;
    }
  }

  Future<void> moveOrderToInProgress({
    required String myUid,
    required String otherUid,
  }) async {
    try {
      log('sending');
      emit(LoadingStates());

      final isOrderMovedToInProgress =
          await db.moveOrderToInProgress(myUid: myUid, otherUserUid: otherUid);

      if (isOrderMovedToInProgress) {
        emit(RequestAcceptedStates());
      } else {
        emit(OrderNotFoundState());
      }
    } catch (e) {
      emit(
        ErrorState(
          message: e.toString(),
        ),
      );
      rethrow;
    }
  }

  Future<void> rejectOrder({
    required String myUid,
    required String otherUid,
  }) async {
    try {
      log('sending');
      emit(RejectLoadingStates());

      final isOrderRejected =
          await db.rejectOrder(myUid: myUid, otherUserUid: otherUid);

      if (isOrderRejected) {
        emit(OrderNotApprovedState());
      } else {
        emit(OrderNotFoundState());
      }
    } catch (e) {
      emit(
        ErrorState(
          message: e.toString(),
        ),
      );
      rethrow;
    }
  }

  String generateOrderID() {
    orderId = DateTime.now().millisecondsSinceEpoch.toString();
    return orderId;
  }

  Future<bool> isOrderSend({
    required String myUid,
    required String otherUid,
  }) async {
    try {
      isOrderAlreadySend =
          await db.isOrderSend(myUid: myUid, otherUid: otherUid);

      return isOrderAlreadySend;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> isOrderApprove({
    required String myUid,
    required String otherUid,
  }) async {
    try {
      isApproved = await db.isOrderApprove(myUid: myUid, otherUid: otherUid);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getNewOrdersLength({required String uid}) async {
    try {
      newOrderLength = await db.getNewOrdersLength(uid);
      emit(OrderCount());
      log(newOrderLength.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getPendingOrdersLength({required String uid}) async {
    try {
      pendingOrderLength = await db.getPendingOrdersLength(uid);
      emit(OrderCount());
      log(pendingOrderLength.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getProgressOrdersLength({required String uid}) async {
    try {
      progressOrderLength = await db.getProgressOrdersLength(uid);
      emit(OrderCount());
      log(progressOrderLength.toString());
    } catch (e) {
      rethrow;
    }
  }
}
