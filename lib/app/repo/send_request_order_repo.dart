import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tailor_app/app/model/measurment_model.dart';
import 'package:tailor_app/app/model/user_model.dart';

class SendRequestOrderRepo {
  Future<void> sendRequest({
    required String senderUid,
    required String recieverUid,
    required UserModel senderUser,
    required UserModel recieverUser,
    required String orderId,
    required String selectedValue,
    required String deliveryDate,
    required MeasurmentModel? measurmentModel,
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
      Map<String, dynamic>? recieveUserMeasurementJson;
      if (measurmentModel != null) {
        recieveUserMeasurementJson = measurmentModel.toJson();
      }
      // Create a map to store the order data, including the list of products
      Map<String, dynamic> orderSendData = {
        'user': recieveUserJson,
        'measurements': recieveUserMeasurementJson,
        'timestamp': FieldValue.serverTimestamp(),
        'docId': recieverUid,
        'orderId': orderId,
        'status': 'pending',
        'orderStatus': '',
        'service': selectedValue,
        'deliveryDate': deliveryDate,
        'tailorId': recieverUid,
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
        'measurements': recieveUserMeasurementJson,
        'docId': senderUid,
        'orderId': orderId,
        'service': selectedValue,
        'deliveryDate': deliveryDate,
        'status': 'pending',
        'orderStatus': '',
        'tailorId': recieverUid,
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
    required String orderId,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Step 1: Get the order data from the receiveOrders collection
      final receiveOrderDoc =
          await firestore.collection('ordersToAdmin').doc(orderId).get();

      if (receiveOrderDoc.exists) {
        // Get the order data
        final orderData = receiveOrderDoc.data();

        // Step 2: Add the order to the pendingOrders collection
        await firestore
            .collection('users')
            .doc(myUid)
            .collection('pendingOrders')
            .doc(otherUserUid) // You can use another ID if needed
            .set({
          ...orderData!,
          'status': 'Approved',
          'orderStatus': 'Pending',
        });
        await firestore
            .collection('ordersToAdmin')
            .doc(orderId)
            .update({'status': 'Approved'});

        // Step 3: Remove the order from the receiveOrders collection
        // await receiveOrderDoc.reference.delete();

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

//         QuerySnapshot receivedOrdersSnapshot = await firestore
//             .collectionGroup(
//                 'receiveOrders') // Get all receiveOrders from any user
//             .where('docId',
//                 isEqualTo: otherUserUid) // Ensure it's the same order
//             .get();

// // Step 2: Remove the order from all users' receiveOrders collections
//         for (var doc in receivedOrdersSnapshot.docs) {
//           await doc.reference.delete();
//           log('Removed From All Users');
//         }
//         QuerySnapshot sendOrdersSnapshot = await firestore
//             .collectionGroup(
//                 'sentOrders') // Get all receiveOrders from any user
//             .where('docId', isNotEqualTo: myUid) // Ensure it's the same order
//             .get();

// // Step 2: Remove the order from all users' receiveOrders collections
//         for (var doc in sendOrdersSnapshot.docs) {
//           await doc.reference.delete();
//           log('Removed From All Users');
//         }
//         log('Order moved to pendingOrders successfully');
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

  Future<bool> sendOrderRequestToAdmin(
      {required String otherUserUid,
      required String myUid,
      required String orderId}) async {
    try {
      final firestore = FirebaseFirestore.instance;

      QuerySnapshot receivedOrdersSnapshot = await firestore
          .collectionGroup(
              'receiveOrders') // Get all receiveOrders from any user
          .where('docId', isEqualTo: otherUserUid)
          .where('tailorId', isNotEqualTo: myUid) // Ensure it's the same order
          .get();

// Step 2: Remove the order from all users' receiveOrders collections
      for (var doc in receivedOrdersSnapshot.docs) {
        await doc.reference.delete();
        log('Removed From All Users');
      }
      QuerySnapshot sentOrdersSnapshot = await firestore
          .collection('users')
          .doc(otherUserUid)
          .collection('sentOrders')
          .where('orderId', isNotEqualTo: orderId) // Match order ID
          .get();

      if (sentOrdersSnapshot.docs.isEmpty) {
        log('No sent orders found for orderId: $orderId');
        // return false;
      }

      // Step 2: Remove order from sentOrders for all tailors except the accepted one
      for (var doc in sentOrdersSnapshot.docs) {
        if (doc['tailorId'] != myUid) {
          await doc.reference.delete();
          log('Removed from sentOrders for tailor: ${doc['tailorId']}');
        }
      }

      // Step 3: Move the accepted order to 'ordersToAdmin'
      final receiveOrderDoc = await firestore
          .collection('users')
          .doc(myUid)
          .collection('receiveOrders')
          .doc(otherUserUid)
          .get();

      if (receiveOrderDoc.exists) {
        // Move order to 'ordersToAdmin'

        // Remove from receiveOrders
        await receiveOrderDoc.reference.delete();

        // Keep the order in sentOrders for the accepted tailor & update status
        final sendOrderDoc = await firestore
            .collection('users')
            .doc(otherUserUid)
            .collection('sentOrders')
            .doc(myUid)
            .get();

        if (sendOrderDoc.exists) {
          final orderData = sendOrderDoc.data();
          await firestore
              .collection('ordersToAdmin')
              .doc(orderId)
              .set({...orderData!, 'CustomerId': myUid});
        }

        await firestore
            .collection('users')
            .doc(otherUserUid)
            .collection('sentOrders')
            .doc(myUid)
            .update({
          'status': 'Approved',
          'orderStatus': 'Pending',
        });

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
            .set({
          ...orderData!,
          'orderStatus': 'In Progress',
        });

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

  Future<bool> moveOrderToCompleted({
    required String otherUserUid,
    required String myUid,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Step 1: Get the order data from the receiveOrders collection
      final inProgressOrderDoc = await firestore
          .collection('users')
          .doc(myUid)
          .collection('inProgressOrders')
          .doc(otherUserUid)
          .get();

      if (inProgressOrderDoc.exists) {
        // Get the order data
        final orderData = inProgressOrderDoc.data();

        // Step 2: Add the order to the pendingOrders collection
        await firestore
            .collection('users')
            .doc(myUid)
            .collection('completeOrders')
            .doc(otherUserUid) // You can use another ID if needed
            .set({
          ...orderData!,
          'orderStatus': 'Complete',
        });

        // Step 3: Remove the order from the receiveOrders collection
        await inProgressOrderDoc.reference.delete();

        // Step 4: Update the status in the sender's sentOrders
        await firestore
            .collection('users')
            .doc(otherUserUid)
            .collection('sentOrders')
            .doc(myUid)
            .update({
          'status': 'Approved',
          'orderStatus': 'Complete',
        });

        log('Order moved to Complete successfully');
        return true;
      } else {
        log('Order does not exist in inprogress');
        return false;
      }
    } catch (e) {
      log('Error moving order: $e');
      rethrow;
    }
  }

  Future<bool> moveOrderToDelivered({
    required String otherUserUid,
    required String myUid,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Step 1: Get the order data from the receiveOrders collection
      await firestore
          .collection('users')
          .doc(myUid)
          .collection('completeOrders')
          .doc(otherUserUid)
          .update({
        'status': 'Approved',
        'orderStatus': 'Delivered',
      });

      // if (completeOrderDoc.exists) {
      // Get the order data
      // final orderData = completeOrderDoc.data();

      // Step 2: Add the order to the pendingOrders collection
      // await firestore
      //     .collection('users')
      //     .doc(myUid)
      //     .collection('deliveredOrders')
      //     .doc(otherUserUid) // You can use another ID if needed
      //     .set(orderData!);

      // Step 3: Remove the order from the receiveOrders collection
      // await inProgressOrderDoc.reference.delete();

      // Step 4: Update the status in the sender's sentOrders
      await firestore
          .collection('users')
          .doc(otherUserUid)
          .collection('sentOrders')
          .doc(myUid)
          .update({
        'status': 'Delivered',
        'orderStatus': 'Delivered',
      });
      final sendOrderDocument = await firestore
          .collection('users')
          .doc(otherUserUid)
          .collection('sentOrders')
          .doc(myUid)
          .get();

      if (sendOrderDocument.exists) {
        final orderData = sendOrderDocument.data();
        await firestore
            .collection('users')
            .doc(otherUserUid)
            .collection('historyOrders')
            .doc(myUid)
            .set({
          ...orderData!,
          'isShowReviewDialogue': false, // Adding the new field
        });
        await sendOrderDocument.reference.delete();

        log('Order deleted from sendOrders successfully');
        log('Order moved to Delivered successfully');

        return true;
      } else {
        log('Order does not exist in inprogress');
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
          .collection('inProgressOrders')
          .get();
      if (snapshot.docs.isNotEmpty) {
        progressOrderCount = snapshot.size;
      }
      return progressOrderCount;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getCompletedOrdersLength(String uid) async {
    try {
      int completeOrderCount = 0;
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('completeOrders')
          .get();
      if (snapshot.docs.isNotEmpty) {
        completeOrderCount = snapshot.size;
      }
      return completeOrderCount;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getTailorReviewLength(String uid) async {
    try {
      int reviewLength = 0;
      final snapshot = await FirebaseFirestore.instance
          .collection('reviews')
          .doc(uid)
          .collection('myReviews')
          .get();
      if (snapshot.docs.isNotEmpty) {
        reviewLength = snapshot.size;
      }
      return reviewLength;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDialogueBool({
    required String otherUserUid,
    required String myUid,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore
          .collection('users')
          .doc(myUid)
          .collection('historyOrders')
          .doc(otherUserUid)
          .update({'isShowReviewDialogue': true});
    } catch (e) {
      rethrow;
    }
  }
}
