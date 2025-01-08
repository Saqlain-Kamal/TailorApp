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
            .update({'status': 'Approved'});

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
}
