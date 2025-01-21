import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tailor_app/app/model/user_model.dart';

class SendRequestOrderRepo {
  Future<void> sendRequest({
    required String senderUid,
    required String recieverUid,
    required UserModel senderUser,
    required UserModel recieverUser,
    required String orderId,
  }) async {
    try {
      final doc = FirebaseFirestore.instance
          .collection('users')
          .doc(senderUid)
          .collection('sentOrders')
          .doc(recieverUid);

      // Convert the list of products to a list of JSON objects

      var name = recieverUser.name;
      print(name);
      final recieveUserJson = recieverUser.toJson();
      // Create a map to store the order data, including the list of products
      Map<String, dynamic> orderSendData = {
        'user': recieveUserJson,
        'timestamp': FieldValue.serverTimestamp(),
        'docId': doc.id,
        'orderId': orderId,
        'status': 'pending',
        'orderStatus': '',
        // Add a timestamp field
        // Add other fields as necessary, such as user ID, total price, etc.
      };

      await doc.set(orderSendData);

      final userDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(recieverUid)
          .collection('receiveOrders')
          .doc(senderUid);
      final senderUserJson = senderUser.toJson();

      Map<String, dynamic> orderRecieveData = {
        'user': senderUserJson,
        'timestamp': FieldValue.serverTimestamp(),
        'docId': doc.id,
        'orderId': orderId,

        // Add a timestamp field
        // Add other fields as necessary, such as user ID, total price, etc.
      };

      await userDoc.set(orderRecieveData);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> acceptOrder({
    required String otherUserUid,
    required String myUid,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Step 1: Get the order data from the receiveOrders collection
      final receiveOrderDoc = await firestore
          .collection('users')
          .doc(myUid)
          .collection('receiveOrders')
          .doc(otherUserUid)
          .get();

      if (receiveOrderDoc.exists) {
        // Get the order data
        final orderData = receiveOrderDoc.data();

        // Step 2: Add the order to the pendingOrders collection
        await firestore
            .collection('users')
            .doc(myUid)
            .collection('pendingOrders')
            .doc(otherUserUid) // You can use another ID if needed
            .set(orderData!);

        // Step 3: Remove the order from the receiveOrders collection
        await receiveOrderDoc.reference.delete();

        // Step 4: Update the status in the sender's sentOrders
        await firestore
            .collection('users')
            .doc(otherUserUid)
            .collection('sentOrders')
            .doc(myUid)
            .update({
          'status': 'Approved',
          'orderStatus': 'Pending',
        });

        log('Order moved to pendingOrders successfully');
        return true;
      } else {
        log('Order does not exist in receiveOrders');
        return false;
      }
    } catch (e) {
      log('Error moving order: $e');
      rethrow;
    }
  }

  Future<bool> moveOrderToInProgress({
    required String otherUserUid,
    required String myUid,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Step 1: Get the order data from the receiveOrders collection
      final pendingOrderDoc = await firestore
          .collection('users')
          .doc(myUid)
          .collection('pendingOrders')
          .doc(otherUserUid)
          .get();

      if (pendingOrderDoc.exists) {
        // Get the order data
        final orderData = pendingOrderDoc.data();

        // Step 2: Add the order to the pendingOrders collection
        await firestore
            .collection('users')
            .doc(myUid)
            .collection('inProgressOrders')
            .doc(otherUserUid) // You can use another ID if needed
            .set(orderData!);

        // Step 3: Remove the order from the receiveOrders collection
        await pendingOrderDoc.reference.delete();

        // Step 4: Update the status in the sender's sentOrders
        await firestore
            .collection('users')
            .doc(otherUserUid)
            .collection('sentOrders')
            .doc(myUid)
            .update({
          'status': 'Approved',
          'orderStatus': 'In Progress',
        });

        log('Order moved to InProgressOrders successfully');
        return true;
      } else {
        log('Order does not exist in PendingOrders');
        return false;
      }
    } catch (e) {
      log('Error moving order: $e');
      rethrow;
    }
  }

  Future<bool> rejectOrder({
    required String otherUserUid,
    required String myUid,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Step 1: Get the order data from the receiveOrders collection
      final receiveOrderDoc = await firestore
          .collection('users')
          .doc(myUid)
          .collection('receiveOrders')
          .doc(otherUserUid)
          .get();

      if (receiveOrderDoc.exists) {
        // Get the order data
        // final orderData = receiveOrderDoc.data();

        // // Step 2: Add the order to the pendingOrders collection
        // await firestore
        //     .collection('users')
        //     .doc(myUid)
        //     .collection('pendingOrders')
        //     .doc(otherUserUid) // You can use another ID if needed
        //     .set(orderData!);

        // Step 3: Remove the order from the receiveOrders collection
        await receiveOrderDoc.reference.delete();

        // Step 4: Update the status in the sender's sentOrders

        final sendOrderDoc = await firestore
            .collection('users')
            .doc(otherUserUid)
            .collection('sentOrders')
            .doc(myUid)
            .get();

        await sendOrderDoc.reference.delete();
        log('Order Deleted from Sender successfully');
        return true;
      } else {
        log('Order does not exist in receiveOrders');
        return false;
      }
    } catch (e) {
      log('Error moving order: $e');
      rethrow;
    }
  }

  Future<bool> isOrderSend({
    required String myUid,
    required String otherUid,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(myUid)
          .collection('sentOrders')
          .doc(otherUid)
          .get();
      return snapshot.exists;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isOrderApprove({
    required String myUid,
    required String otherUid,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(myUid)
          .collection('sentOrders')
          .doc(otherUid)
          .get();

      if (snapshot.exists) {
        final orderData = snapshot.data();
        final status = orderData!['status'];

        if (status == 'Approved') {
          return true;
        } else {
          return false;
        }
      } else {
        return false; // The order does not exist
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getNewOrdersLength(String uid) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('receiveOrders')
          .get();

      final newOrderCount = snapshot.size;
      return newOrderCount;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getPendingOrdersLength(String uid) async {
    try {
      int pendingOrderCount = 0;
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('pendingOrders')
          .get();
      if (snapshot.docs.isNotEmpty) {
        pendingOrderCount = snapshot.size;
      }
      return pendingOrderCount;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getProgressOrdersLength(String uid) async {
    try {
      int progressOrderCount = 0;
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('progressOrders')
          .get();
      if (snapshot.docs.isNotEmpty) {
        progressOrderCount = snapshot.size;
      }
      return progressOrderCount;
    } catch (e) {
      rethrow;
    }
  }
}
